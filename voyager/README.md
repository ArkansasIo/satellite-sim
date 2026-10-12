# Voyager Subsystem Simulation

This folder is reserved for a source-grounded Voyager subsystem emulator. It is intentionally separate from the generic CPU under `include/satellite/`.

## Historical architecture

NASA describes Voyager as having three computer subsystem types, with two units of each: CCS (18-bit), FDS (16-bit), and AACS (18-bit). The subsystems have different responsibilities; they must not be represented as one interchangeable CPU. See [the NASA Voyager FAQ](https://science.nasa.gov/mission/voyager/frequently-asked-questions/) and [NASA's spacecraft overview](https://science.nasa.gov/mission/voyager/spacecraft/).

## Current status

This directory currently establishes the implementation boundary and design intent. It is not yet a complete or validated Voyager emulator. The next implementation target is the FDS because a public emulator and historical architecture references are available. The FDS implementation must be checked against primary JPL documentation before being called instruction-accurate.

## Scope

- Dedicated FDS 16-bit machine model.
- Separate CCS and AACS behavioral models, with 18-bit architecture where supported by documentation.
- Two instances per subsystem type to represent redundancy.
- Explicit source provenance for instruction behavior.
- Integration with the project's spacecraft, delayed communications, telemetry, and scenario systems.

## Related documents

- `docs/voyager-reproduction-research.md`
- `docs/voyager-reproduction-plan.md`
- `docs/assembly-reference.md` for the existing generic simulator ISA (not Voyager ISA).
