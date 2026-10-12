# Voyager Ground-System Simulator

This directory defines the historical ground-system simulation boundary for the Voyager-inspired spacecraft model.

## Responsibilities

- Mission-control console and operator event log.
- Command sequence authoring, validation, versioning, scheduling, and audit.
- Simulated DSN stations with contact windows, uplink/downlink state, and light-time.
- Telemetry frame reception, decoding, engineering conversion, alarms, archive, and replay.
- Tracking and navigation data with explicit provenance.
- CRT-style and modern operator-console presentation modes.

## Important boundaries

- This is a source-grounded simulation, not original JPL/DSN software.
- Command transmission is simulated; no real spacecraft control is implemented.
- Do not fabricate telemetry during gaps or treat demo Earth-orbit GPS fields as actual Voyager navigation.
- Historical frame formats, command codes, and exact station behavior require primary-source verification before implementation.

See `docs/voyager-ground-system.md` for architecture, contracts, research sources, and test scenarios.
