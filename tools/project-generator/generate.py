#!/usr/bin/env python3
"""Generate deterministic scaffold headers from a satellite-sim profile.

The generator intentionally creates scaffolding, not production implementations.
"""
from __future__ import annotations

import argparse
import json
import re
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
            module = line[2:].strip().strip("'").strip('"')
            if module:
                profile["modules"].append(module)
    return profile


def safe_identifier(value: str) -> str:
    """Return a valid uppercase C++ identifier for any profile/module label."""
    identifier = re.sub(r"[^A-Za-z0-9_]", "_", value).upper()
    if not identifier or identifier[0].isdigit():
        identifier = "_" + identifier
    return identifier


def module_source(profile: str, module: str) -> str:
    guard = safe_identifier(f"SATSim_Generated_{module}_HPP")
    # JSON string literals are valid C++ string literals for these ASCII labels.
    profile_literal = json.dumps(profile)
    module_literal = json.dumps(module)
    struct_name = safe_identifier(module) + "Module"
    return (
        "// GENERATED FILE. DO NOT EDIT MANUALLY.\n"
        f"// profile: {profile}\n"
        f"// module: {module}\n\n"
        f"#ifndef {guard}\n#define {guard}\n\n"
        "#include <string_view>\n\n"
        "namespace satellite::generated {\n"
        f"struct {struct_name} final {{\n"
        f"    static constexpr std::string_view profile = {profile_literal};\n"
        f"    static constexpr std::string_view module = {module_literal};\n"
        "};\n"
        "} // namespace satellite::generated\n\n"
        f"#endif // {guard}\n"
    )


def generate(profile_name: str, output: Path) -> list[Path]:
    if not re.fullmatch(r"[a-zA-Z0-9_-]+", profile_name):
        raise SystemExit(f"Invalid profile name: {profile_name}")
    profile_path = PROFILE_DIR / f"{profile_name}.yaml"
    if not profile_path.is_file():
        raise SystemExit(f"Unknown profile: {profile_name}")

    profile = parse_profile(profile_path)
    if not profile["modules"]:
        raise SystemExit(f"Profile has no modules: {profile_name}")

    profile_output = output / profile_name
    profile_output.mkdir(parents=True, exist_ok=True)
    manifest = {
        "generator": "tools/project-generator/generate.py",
        "profile": profile["name"],
        "source_spec": str(profile_path.relative_to(ROOT)),
        "artifacts": [],
    }
    written: list[Path] = []
    for module in profile["modules"]:
        # Flatten slash-separated module paths to avoid unexpected traversal.
        filename = re.sub(r"[^A-Za-z0-9_-]", "_", module).replace("/", "_").replace("-", "_").lower() + ".hpp"
        path = profile_output / filename
        path.write_text(module_source(profile_name, module), encoding="utf-8")
        relative = path.relative_to(ROOT) if path.is_relative_to(ROOT) else path
        manifest["artifacts"].append(relative.as_posix())
        written.append(path)

    manifest_path = profile_output / "manifest.json"
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    return written


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate satellite-sim scaffold headers.")
    parser.add_argument("--profile", choices=("mvp", "commercial", "extended"), required=True)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    paths = generate(args.profile, args.output)
    print(f"Generated {len(paths)} scaffold headers for profile {args.profile}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
