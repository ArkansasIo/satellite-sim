# Source Tree and Implementation Status

This document distinguishes the checked-in implementation from planned or generated scaffolding.

## Implemented C++ sources

The CMake target currently builds the CPU, assembler, radio-link, spacecraft, ground-station, fleet, mission-bus, memory, patch, and update translation units. Public headers under `include/satellite/` define the current interfaces.

## Generator behavior

The profile generator reads a simple YAML subset (`modules:` followed by list items) without an external YAML dependency. Each profile produces one placeholder C++ header per listed module and a JSON manifest. Output is intentionally labeled generated scaffolding; no generator output should be treated as a finished module implementation.

## Known engineering limitations to track

- Expand CPU tests to cover each instruction, register bounds, PC bounds, width masking, invalid opcodes, I/O and maximum execution-step handling.
- Improve assembler diagnostics (source line numbers, register validation, label resolution, range checks and duplicate-label rejection).
- Add deterministic random seeding and packet-level telemetry for radio loss/delay tests.
- Define serialization/versioning for commands and telemetry before exposing a production API.
- Add a real API service only after authentication, authorization, rate limits, audit logs and schema validation are designed.
- Hardware-in-loop support requires documented bench procedure, electrical review and explicit separation from flight hardware.
- The current API document is an endpoint outline, not evidence that an HTTP server or database service exists.

## Verification

The GitHub Actions workflow builds with CMake, executes native CTest tests, and runs Python generator tests on pushes and pull requests. Passing CI verifies compilation and those tests only; it does not validate flight software, historical fidelity, or hardware safety.
