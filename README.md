# Satellite Sim

A virtual deep-space spacecraft and ground-station simulation platform. This repository combines a C++20 simulator, assembly/virtual-CPU experiments, Arduino bench prototypes, telemetry/protocol documentation, and source-tree generation tools.

## Current project scope

- Virtual CPU profiles at 8, 18, 32 and 64 bits
- A compact teaching ISA and assembly examples
- Spacecraft, radio-link, ground-station, fleet, memory and update components
- Telemetry and command protocol experiments
- Arduino/AVR bench prototype scaffolding
- MVP, commercial and extended source-scaffold profiles
- CMake-based native build and CTest entry points

This is an educational simulation project. It is **not** flight-qualified software and does not control real spacecraft.

## Build and test

Requirements: CMake 3.20+, a C++20 compiler, and Python 3 for generator tests.

```sh
cmake -S . -B build
cmake --build build --parallel
ctest --test-dir build --output-on-failure
```

Run the project-generator tests:

```sh
python -m unittest discover -s tools/project-generator/tests -p 'test_*.py'
```

Run the demo on Linux/macOS with `bash tools/run_demo.sh`, or on Windows with `powershell -ExecutionPolicy Bypass -File tools/run_demo.ps1`.

## Project generator

```sh
python tools/project-generator/generate.py --profile mvp
python tools/project-generator/generate.py --profile commercial
python tools/project-generator/generate.py --profile extended
python tools/project-generator/generate_all.py --output generated/project
```

Generated headers are **scaffolding only**. They provide deterministic placeholders and must not be mistaken for implemented mission functionality.

## Layout

- `include/satellite/`: public C++ interfaces
- `src/core/`: simulator implementation
- `tests/`: native test executables
- `asm/` and `arduino/`: low-level and embedded experiments
- `missions/`, `protocols/`, `ground-station/`, `sim/`: model and design material
- `api/` and `ui/`: interface outlines
- `tools/project-generator/`: deterministic profile-driven scaffold generator
- `docs/`: architecture and engineering notes

## Fidelity and safety notes

The virtual ISA and CPU profiles are project-defined models, not claims about the exact flight-computer instruction set used by a historical spacecraft. Hardware-specific or mission-specific values should cite authoritative sources in the relevant documentation. Arduino instructions are for a low-voltage educational bench setup and must be reviewed before any physical wiring.

## License

This project is distributed under the MIT License; retain the license and notices with redistributed copies.
