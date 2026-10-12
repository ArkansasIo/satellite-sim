# Satellite Sim

A virtual deep-space spacecraft and ground-station simulation platform.

## Mission profiles

- `missions/voyager-style/` — historically inspired deep-space spacecraft profile.
- `missions/modern/` — current-technology spacecraft profile.
- Both profiles use the same abstract spacecraft, command, telemetry, radio-link, and ground-station APIs.

## CPU targets

The virtual flight-computer layer is designed for:

- 8-bit
- 18-bit historically inspired target
- 32-bit
- 64-bit

The CPU width is selected by the mission profile and does not change the higher-level spacecraft API.

## Simulation loop

Ground command → simulated deep-space radio link → spacecraft command decoder → flight CPU/ASM → spacecraft subsystems → telemetry encoder → radio link → ground station.

The simulator can model signal delay, power constraints, antenna state, subsystem faults, mission time, and bidirectional telemetry/commands.

## Repository layout

```
asm/                    Assembly dialects and examples
docs/                   Architecture and protocol documentation
missions/               Historical and modern spacecraft profiles
sim/                    Simulation engine and virtual spacecraft
ground-station/         Command and telemetry consoles
protocols/              Command/telemetry definitions
tests/                  Deterministic simulation tests
tools/                  Assembler/emulator utilities
```

## Status

Initial architecture and executable-oriented scaffold. Historical hardware values are intentionally modeled as an emulation target, not presented as a claim that the real Voyager spacecraft used this exact CPU implementation.
