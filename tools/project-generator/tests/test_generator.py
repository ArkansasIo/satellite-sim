import json
import tempfile
import unittest
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "tools" / "project-generator"))
from generate import generate, module_source, safe_identifier


class ProjectGeneratorTests(unittest.TestCase):
    def test_profiles_generate_nonempty_manifests(self):
        with tempfile.TemporaryDirectory() as temp:
            for profile in ("mvp", "commercial", "extended"):
                paths = generate(profile, Path(temp))
                manifest_path = Path(temp) / profile / "manifest.json"
                self.assertTrue(paths)
                self.assertTrue(manifest_path.exists())
                manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
                self.assertEqual(manifest["profile"], profile)
                self.assertEqual(len(manifest["artifacts"]), len(paths))
                self.assertTrue(all(path.is_file() for path in paths))

    def test_extended_has_more_modules_than_mvp(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            mvp = len(generate("mvp", root))
            extended = len(generate("extended", root))
            self.assertGreater(extended, mvp)

    def test_identifiers_are_valid_for_punctuated_module_names(self):
        self.assertEqual(safe_identifier("core/radio-link"), "CORE_RADIO_LINK")
        source = module_source("mvp", "core/radio-link")
        self.assertIn('profile = "mvp";', source)
        self.assertIn('module = "core/radio-link";', source)
        self.assertIn("struct CORE_RADIO_LINKModule", source)

    def test_unknown_profile_fails(self):
        with self.assertRaises(SystemExit):
            generate("not-a-profile", Path(tempfile.gettempdir()) / "not-created")


if __name__ == "__main__":
    unittest.main()
