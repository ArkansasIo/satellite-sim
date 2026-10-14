# Satellite Sim

Satellite Sim is an educational C++20 spacecraft and ground-station simulation project. It combines a virtual CPU and assembler, spacecraft/radio/ground-station models, telemetry and command protocol experiments, and supporting embedded-system research.

> **Simulation only:** this project is not flight-qualified software and must not be used to command or control real spacecraft.

## Start here

- [Build and run the simulator](build.md)
- [Architecture overview](architecture.md)
- [Implementation status and known gaps](IMPLEMENTATION_STATUS.md)
- [Source tree reference](source-tree.md)
- [API design reference](api-reference.md)
- [Security model](security-model.md)

## Interactive browser simulator

Launch the [Satellite Sim Mission Control app](simulator/index.html) for an interactive Earth-orbit visualization, multi-satellite registry, orbital parameter controls, ground-station visibility, live telemetry, and a local command/event log. The app runs entirely in your browser and does not connect to a spacecraft or a live backend. See the [browser API reference](simulator-api.md) for integration details.

## Capabilities in the repository

- Virtual CPU profiles (8-, 18-, 32-, and 64-bit)
- Teaching instruction set and assembly examples
- Spacecraft, radio link, ground station, fleet and mission-bus components
- Telemetry, command, memory and update protocol design
- CMake build and CTest native test suite
- Arduino/AVR experiments and project-scaffold generator

## Important distinction

Some directories contain implemented C++ code, while others contain specifications, research notes, or scaffolding. The documentation labels these differences explicitly; a design document does not mean a service or feature is already running.

Source code: [GitHub repository](https://github.com/ArkansasIo/satellite-sim).
