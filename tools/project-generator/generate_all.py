#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path

from generate import generate


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate all satellite-sim project profiles.")
    parser.add_argument("--output", type=Path, default=Path("generated/project"))
    args = parser.parse_args()

    for profile in ("mvp", "commercial", "extended"):
        generate(profile, args.output)

    print("Generated MVP, commercial, and extended project trees.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
