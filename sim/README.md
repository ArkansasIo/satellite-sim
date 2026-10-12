# Simulation Engine

The simulation engine owns authoritative mission time and state.

Recommended runtime components:

- SimulationClock
- EventQueue
- RadioLink
- Spacecraft
- FlightComputer
- Memory
- InstructionSet
- SubsystemManager
- TelemetryBus
- CommandBus
- FaultInjector
- ScenarioRunner

A later implementation can expose these components through a native C++, Rust, or TypeScript host while keeping the ASM virtual-machine ABI stable.
