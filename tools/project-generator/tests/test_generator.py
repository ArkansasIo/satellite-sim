import tempfile
import unittest
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from generate import generate


class ProjectGeneratorTests(unittest.TestCase):
    def test_profiles_generate(self):
        for profile in ("mvp", "commercial", "extended"):
            with tempfile.TemporaryDirectory() as temp:
                paths = generate(profile, Path(temp))
                self.assertGreater(len(paths), 0)
                self.assertTrue((Path(temp) / profile / "manifest.json").exists())

    def test_extended_has_more_modules_than_mvp(self):
        with tempfile.TemporaryDirectory() as temp:
            mvp = len(generate("mvp", Path(temp) / "mvp-out"))
            extended = len(generate("extended", Path(temp) / "extended-out"))
            self.assertGreater(extended, mvp)


if __name__ == "__main__":
    unittest.main()
