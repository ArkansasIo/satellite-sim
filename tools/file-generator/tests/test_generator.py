import csv
import tempfile
import unittest
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from generate import build_summary, load_staffing, write_outputs


class GeneratorTests(unittest.TestCase):
    def test_staffing_schema(self):
        path = ROOT / "docs" / "staffing-costs.csv"
        with path.open(newline="", encoding="utf-8") as handle:
            fields = set(csv.DictReader(handle).fieldnames or [])
        self.assertTrue({"scenario", "role", "count", "estimated_loaded_cost_cad_per_year"}.issubset(fields))

    def test_summary_contains_both_scenarios(self):
        rows = load_staffing(ROOT / "docs" / "staffing-costs.csv")
        summary = build_summary(rows)
        self.assertEqual(set(summary), {"MVP", "Commercial"})
        self.assertGreater(summary["MVP"]["headcount"], 0)
        self.assertGreater(summary["Commercial"]["headcount"], 0)

    def test_generator_creates_package(self):
        rows = load_staffing(ROOT / "docs" / "staffing-costs.csv")
        with tempfile.TemporaryDirectory() as temp:
            output = Path(temp)
            write_outputs(output, build_summary(rows))
            for name in ("program-summary.json", "program-summary.md", "budget-summary.csv", "hiring-schedule.md", "staffing-generated.json", "manifest.json"):
                self.assertTrue((output / name).exists())


if __name__ == "__main__":
    unittest.main()
