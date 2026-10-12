# Satellite Memory and Updates

The simulator has two conceptual storage generations.

## Legacy spacecraft

Magnetic-core-style memory is modeled as persistent word-addressable storage. It is deliberately a simulation abstraction rather than a claim about the exact memory technology used by a historical spacecraft.

The legacy update path is conservative: stage -> verify -> apply -> reboot/continue.

## Modern spacecraft

Modern profiles use a virtual flash/NVRAM model with versioned update packages, checksums, staged writes, configuration updates, and rollback metadata.

## Common update pipeline

Ground Station -> delayed radio link -> command receiver -> patch staging -> integrity verification -> memory write -> boot/flight software activation -> telemetry confirmation.

The same pipeline can update one spacecraft or a selected group in a constellation.
