#!/usr/bin/env python3
"""Static smoke tests for the GitHub Pages browser simulator."""
from __future__ import annotations

import re
import subprocess
import tempfile
from html.parser import HTMLParser
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
APP = ROOT / "docs" / "simulator" / "index.html"


class IdCollector(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.ids: list[str] = []
        self.errors: list[str] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        for key, value in attrs:
            if key == "id" and value:
                self.ids.append(value)

    def error(self, message: str) -> None:
        self.errors.append(message)


def main() -> int:
    if not APP.is_file():
        raise SystemExit(f"FAIL: app file missing: {APP}")
    html = APP.read_text(encoding="utf-8")
    parser = IdCollector()
    parser.feed(html)
    duplicates = sorted({item for item in parser.ids if parser.ids.count(item) > 1})
    if duplicates:
        raise SystemExit("FAIL: duplicate HTML ids: " + ", ".join(duplicates))

    required_ids = {
        "orbitCanvas", "satList", "altitude", "inclination", "eccentricity",
        "stationApply", "telemetryRows", "eventLog", "displayMode", "brightness",
        "scanlines", "colorMode", "exportJson", "exportCsv", "savePrefs",
    }
    missing = sorted(required_ids - set(parser.ids))
    if missing:
        raise SystemExit("FAIL: required app controls missing: " + ", ".join(missing))

    scripts = re.findall(r"<script>(.*?)</script>", html, flags=re.I | re.S)
    if len(scripts) != 1:
        raise SystemExit(f"FAIL: expected one inline application script, found {len(scripts)}")
    if "window.SatelliteSim" not in scripts[0]:
        raise SystemExit("FAIL: public SatelliteSim browser API is missing")

    with tempfile.NamedTemporaryFile("w", suffix=".js", encoding="utf-8", delete=False) as tmp:
        tmp.write(scripts[0])
        js_path = Path(tmp.name)
    try:
        result = subprocess.run(["node", "--check", str(js_path)], capture_output=True, text=True)
        if result.returncode:
            raise SystemExit("FAIL: JavaScript syntax check failed:\n" + result.stderr)
    finally:
        js_path.unlink(missing_ok=True)

    print(f"PASS: simulator HTML parsed; {len(parser.ids)} unique IDs; JavaScript syntax valid")
    print("PASS: orbital controls, telemetry, ground station, CRT settings, and JSON/CSV exports are present")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
