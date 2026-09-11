import importlib.util
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("release_sync", ROOT / "scripts/sync_app_store_release.py")
sync = importlib.util.module_from_spec(spec)
spec.loader.exec_module(sync)


def payload(version="5.32", app_id=6780299502):
    return {"resultCount": 1, "results": [{"trackId": app_id, "version": version, "trackName": "My T Data"}]}


class AppleRecordTests(unittest.TestCase):
    def test_public_update_uses_apple_and_neutral_link(self):
        record = sync.release_record(payload(), {"version": "3.10"})
        self.assertEqual(record["version"], "5.32")
        self.assertEqual(record["track_name"], "My T Data")
        self.assertEqual(record["track_view_url"], "https://apps.apple.com/app/id6780299502")

    def test_unchanged_listing_does_not_create_daily_commit(self):
        record = sync.release_record(payload())
        record["checked_at"] = "2000-01-01T00:00:00Z"
        self.assertIsNone(sync.release_record(payload(), record))

    def test_storefront_lag_cannot_downgrade_public_version(self):
        with self.assertRaisesRegex(ValueError, "backwards"):
            sync.release_record(payload("5.31"), {"version": "5.32"})

    def test_numeric_version_comparison_accepts_future_601(self):
        self.assertEqual(sync.release_record(payload("6.01"), {"version": "5.32"})["version"], "6.01")
        self.assertEqual(sync.version_parts("5.3"), sync.version_parts("5.3.0"))

    def test_wrong_or_multiple_apple_apps_fail_closed(self):
        for value in [payload(app_id=6798103086), {"resultCount": 0, "results": []},
                      {"resultCount": 1, "results": payload()["results"] * 2}]:
            with self.subTest(value=value), self.assertRaises(ValueError):
                sync.release_record(value)

    def test_version_cannot_inject_branch_or_shell_syntax(self):
        for value in [None, "", "v6.01", "6.01/new", "6.01;echo bad", "$(id)", "6.01\n", "6.1.2.3"]:
            with self.subTest(value=value), self.assertRaises(ValueError):
                sync.release_record(payload(value))


class DocumentationContractTests(unittest.TestCase):
    def test_released_together_has_localized_assets_and_video_links(self):
        for suffix, locale, status in [("", "en", "My T 6.01 is publicly available"),
                                       (".zh-Hans", "zh-Hans", "My T 6.01 已公开上架"),
                                       (".zh-Hant", "zh-Hant", "My T 6.01 已公開上架")]:
            text = (ROOT / f"README{suffix}.md").read_text()
            asset = f"docs/images/{locale}/11-together-preview.png"
            self.assertIn(asset, text)
            self.assertTrue((ROOT / asset).is_file())
            self.assertIn(status, text)
            self.assertIn(f'https://www.my-tesla.app/{locale.lower()}/#my-t-video', text)
            self.assertIn(f'myt-6.01-{locale.lower()}.jpg" width="220"', text)
        self.assertNotIn("Waiting for Review", (ROOT / "README.md").read_text())

    def test_trilingual_privacy_contains_friend_sharing_section(self):
        sections = [("", "## Optional Friend Together sharing in 6.01"),
                    (".zh-Hans", "## 6.01 可选朋友同行共享"),
                    (".zh-Hant", "## 6.01 選用朋友同行共享")]
        for suffix, heading in sections:
            text = (ROOT / f"PRIVACY{suffix}.md").read_text()
            self.assertIn(heading, text)
            self.assertIn("Apple Maps", text)


class ProtectedProposalTests(unittest.TestCase):
    """Run the real Git flow against a local bare repo; mock only GitHub API CLI."""

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.directory = Path(self.temp.name)
        self.work = self.directory / "work"
        self.remote = self.directory / "remote.git"
        self.work.mkdir()
        self.git("init", "--bare", str(self.remote))
        self.git("init", "-b", "main")
        self.git("config", "user.name", "Test")
        self.git("config", "user.email", "test@example.invalid")
        (self.work / "scripts").mkdir()
        (self.work / "docs").mkdir()
        for name in ["propose_app_store_release.sh", "sync_app_store_release.py"]:
            shutil.copyfile(ROOT / "scripts" / name, self.work / "scripts" / name)
        (self.work / ".gitignore").write_text("__pycache__/\n")
        self.record = self.work / "docs/app-store-release.json"
        self.record.write_text(json.dumps(sync.release_record(payload("3.10"))))
        self.git("add", ".")
        self.git("commit", "-m", "baseline")
        self.git("remote", "add", "origin", str(self.remote))
        self.git("push", "origin", "main")
        self.base = self.git("rev-parse", "HEAD").strip()
        self.bin = self.directory / "bin"
        self.bin.mkdir()
        fake = self.bin / "gh"
        fake.write_text("""#!/usr/bin/env python3
import json,os,pathlib,subprocess,sys
args=sys.argv[1:]
folder=pathlib.Path(os.environ['TEST_GH_FOLDER'])
with (folder/'calls').open('a') as output: output.write(json.dumps(args)+'\\n')
state=folder/'pr'
if args[:2]==['pr','list']:
    print('17' if state.exists() else '')
elif args[:2]==['pr','create']:
    if os.environ.get('TEST_PR_DENIED'):
        print('GitHub Actions cannot create pull requests',file=sys.stderr); sys.exit(1)
    head=args[args.index('--head')+1]
    state.write_text(subprocess.check_output(['git','rev-parse',head],text=True).strip())
    print('https://github.com/MatchHar/My-T-App/pull/17')
elif args[:2]==['pr','view']:
    print(state.read_text())
elif args[:2] not in [['workflow','run'],['pr','merge']]:
    sys.exit('Unexpected gh command')
""")
        fake.chmod(0o755)
        self.env = dict(os.environ, GITHUB_REPOSITORY="MatchHar/My-T-App",
                        TEST_GH_FOLDER=str(self.directory), PATH=f"{self.bin}:{os.environ['PATH']}")
        self.env.pop("GITHUB_STEP_SUMMARY", None)

    def git(self, *args):
        return subprocess.check_output(["git", *args], cwd=self.work, stderr=subprocess.DEVNULL, text=True)

    def propose(self):
        return subprocess.run(["bash", "scripts/propose_app_store_release.sh"],
                              cwd=self.work, env=self.env, capture_output=True, text=True)

    def changed_record(self):
        self.record.write_text(json.dumps(sync.release_record(payload())))

    def calls(self):
        path = self.directory / "calls"
        return [json.loads(line) for line in path.read_text().splitlines()] if path.exists() else []

    def test_change_proposes_only_json_dispatches_ci_and_never_pushes_main(self):
        self.changed_record()
        result = self.propose()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.git("ls-remote", "origin", "refs/heads/main").split()[0], self.base)
        self.assertEqual(self.git("diff", "--name-only", self.base, "HEAD").strip(), "docs/app-store-release.json")
        calls = self.calls()
        dispatch = next(c for c in calls if c[:2] == ["workflow", "run"])
        self.assertEqual(dispatch[2], "docs.yml")
        self.assertTrue(dispatch[-1].startswith("automation/app-store-version-5.32-"))
        merge = next(c for c in calls if c[:2] == ["pr", "merge"])
        self.assertIn("--auto", merge)
        self.assertIn("--match-head-commit", merge)
        self.assertNotIn("--admin", merge)

    def test_rerun_reuses_exact_proposal_without_second_commit_or_pr(self):
        self.changed_record()
        self.assertEqual(self.propose().returncode, 0)
        head = self.git("rev-parse", "HEAD").strip()
        branch = self.git("branch", "--show-current").strip()
        self.git("switch", "main")
        self.changed_record()
        result = self.propose()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.git("ls-remote", "origin", f"refs/heads/{branch}").split()[0], head)
        self.assertEqual(sum(c[:2] == ["pr", "create"] for c in self.calls()), 1)

    def test_unrelated_file_aborts_before_github_or_push(self):
        self.changed_record()
        (self.work / "unexpected.txt").write_text("unrelated content")
        result = self.propose()
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(self.calls(), [])
        self.assertEqual(self.git("ls-remote", "--heads", "origin").split()[1], "refs/heads/main")

    def test_missing_pr_permission_fails_without_attempting_merge(self):
        self.changed_record()
        self.env["TEST_PR_DENIED"] = "1"
        self.assertNotEqual(self.propose().returncode, 0)
        self.assertFalse(any(c[:2] == ["pr", "merge"] for c in self.calls()))
        self.assertEqual(self.git("ls-remote", "origin", "refs/heads/main").split()[0], self.base)

    def test_unchanged_record_is_noop(self):
        result = self.propose()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), [])
        self.assertEqual(self.git("branch", "--show-current").strip(), "main")


if __name__ == "__main__":
    unittest.main()
