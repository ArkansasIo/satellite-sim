#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PROFILE_DIR = ROOT / "tools" / "project-generator" / "profiles"
DEFAULT_OUTPUT = ROOT / "generated" / "source"


def parse_profile(path: Path) -> dict:
    profile = {"name": path.stem, "modules": []}
    section = None
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if line == "modules:":
            section = "modules"
            continue
        if section == "modules" and line.startswith("- "):
            profile["modules"].append(line[2:].strip())
    return profile


def module_source(profile: str, module: str) -> str:
    guard = module.upper().replace("-", "_").replace("/", "_")
    return (
        "// GENERATED FILE. DO NOT EDIT MANUALLY.\n"
        f"// profile: {profile}\n"
        f"// module: {module}\n\n"
        f"#ifndef SATSIM_GENERATED_{guard}_HPP\n"
        f"#define SATSIM_GENERATED_{guard}_HPP\n\n"
        "namespace satellite::generated {\n"
        f"struct {guard}Module {{ static constexpr const char* profile = "{profile}"; }};\n"
        "}\n\n"
        f"#endif // SATSIM_GENERATED_{guard}_HPP\n"
    )


def generate(profile_name: str, output: Path) -> list[Path]:
    profile_path = PROFILE_DIR / f"{profile_name}.yaml"
    if not profile_path.exists():
        raise SystemExit(f"Unknown profile: {profile_name}")
    profile = parse_profile(profile_path)
    output.mkdir(parents=True, exist_ok=True)

    manifest = {
        "generator": "tools/project-generator/generate.py",
        "profile": profile["name"],
        "source_spec": str(profile_path.relative_to(ROOT)),
        "artifacts": [],
    }

    for module in profile["modules"]:
        filename = module.replace("/", "_").replace("-", "_").lower() + ".hpp"
        path = output / profile_name / filename
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(module_source(profile_name, module), encoding="utf-8")
        manifest["artifacts"].append(str(path.relative_to(ROOT)))

    manifest_path = output / profile_name / "manifest.json"
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    return [Path(x) for x in manifest["artifacts"]]


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", choices=("mvp", "commercial", "extended"), required=True)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    generate(args.profile, args.output)
    print(f"Generated {args.profile} project source tree.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
