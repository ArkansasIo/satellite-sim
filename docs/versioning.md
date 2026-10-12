# Versioning and Build Information

Product: satellite-sim
Current development version: 0.4.0
Versioning scheme: Semantic Versioning.

## Version layers

| Identifier | Purpose |
|---|---|
| Product version | Overall application release |
| API version | Ground/spacecraft service API compatibility |
| Simulator protocol version | Event and runtime protocol compatibility |
| Voyager model version | Voyager reconstruction model compatibility |
| Ground-system model version | Mission-control/DSN simulation compatibility |
| CPU model version | Generic virtual CPU compatibility |
| Telemetry schema version | Telemetry data contract compatibility |
| Command schema version | Command product compatibility |

## Build metadata

Every executable should expose the product name/version, build configuration, Git commit, UTC build timestamp, compiler/version, operating system, CPU architecture, API/protocol versions, enabled profiles, and historical-model versions.

Build timestamp and Git commit are generated at build time. Runtime simulation time must never be used as the software build timestamp.

## Reproducibility

A reproducible build uses the same source revision, dependency versions, compiler/toolchain, configuration, and deterministic build inputs. The mission clock is independent of build metadata.

## CLI

    satellite-sim --version
    satellite-sim --build-info
    satellite-sim --credits

Example:

    satellite-sim 0.4.0
    Voyager model: 0.1.0
    Ground-system model: 0.1.0
    Simulator protocol: 1
    Build: <git-commit>
    Compiler: <compiler> <version>
    Platform: <platform>

## Compatibility

Releases must document breaking API changes, telemetry/command schema changes, scenario-format changes, emulator instruction-set changes, and database migrations.

Use MAJOR for incompatible public interfaces, MINOR for backward-compatible functionality, PATCH for backward-compatible fixes, and prerelease identifiers such as alpha.1, beta.1, and rc.1 before stable releases.
