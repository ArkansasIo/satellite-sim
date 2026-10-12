# UML and Architecture Diagrams

Diagrams use PlantUML source files so they remain editable and reviewable in Git.

- `system-context.puml`: spacecraft, ground station, and mission-control context.
- `spacecraft-subsystems.puml`: CCS/FDS/AACS responsibilities and redundancy.
- `ground-command-sequence.puml`: command lifecycle from mission control to onboard execution.
- `telemetry-sequence.puml`: downlink processing and archive flow.
- `module-components.puml`: software component dependencies.

Diagrams express the intended architecture, not proof that every box is already implemented. Each component should be updated as code and test coverage evolve.
