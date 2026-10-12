# Satellite-Sim Project Generator

The project generator expands the planning model into reproducible source-tree manifests and source files.

## Profiles

- **MVP** — core simulator, ground station, database, UI, embedded prototype, tests.
- **Commercial** — adds security, telemetry/data, deployment, media, operational tooling.
- **Extended** — adds advanced simulation, expanded mission systems, hardware-in-loop scaffolding, research modules, and extended test/documentation surfaces.

## Usage

    python tools/project-generator/generate.py --profile mvp
    python tools/project-generator/generate.py --profile commercial
    python tools/project-generator/generate.py --profile extended

Use `--output` to select the generated directory.

The generator is deterministic. It creates a manifest for every generated artifact and records the selected profile.

Generated source is simulation/prototype code unless a module explicitly documents a production or hardware-validation requirement.
