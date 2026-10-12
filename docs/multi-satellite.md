# Multi-Satellite Simulation

The mission layer supports multiple independent spacecraft in one simulation.

Architecture:

Ground Station
  -> Mission Bus
  -> Satellite Registry
  -> Per-Satellite Command Queue
  -> Radio Link
  -> Flight Computer
  -> Subsystems
  -> Telemetry Router
  -> Ground Station

Each satellite has an independent CPU, memory, mission clock state, radio link, power model, antenna state, telemetry stream, and fault domain.

The fleet layer permits mixed CPU widths and mixed mission profiles in the same scenario.

Recommended future extensions:
- inter-satellite links
- constellation routing
- orbital propagation
- ephemeris
- autonomous navigation
- packet routing and store-and-forward
- constellation-wide fault injection
- synchronized mission replay
