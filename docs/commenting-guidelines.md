# Source Documentation Guidelines

Every production source file should document:

- purpose
- ownership
- inputs/outputs
- state transitions
- units
- error behavior
- simulation-only assumptions
- thread/scheduling assumptions when relevant
- extension points

Assembly files should comment hardware-facing I/O ports and describe registers used by routines. C++ files should keep public contracts in headers and implementation details in source files.
