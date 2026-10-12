# File-by-File Reference

## Build

`CMakeLists.txt` defines the C++20 project, builds `satellite_core`, links the simulator executable, and registers unit-test executables with CTest.

## Core headers

`include/satellite/types.hpp` — common scalar types, CPU widths, telemetry, commands, link configuration, and width masking.

`include/satellite/cpu.hpp` — virtual CPU interface: reset, program loading, stepping, execution, registers, PC, I/O, and halt state.

`include/satellite/assembler.hpp` — source-to-instruction assembly interface.

`include/satellite/radio_link.hpp` — delayed bidirectional command/telemetry transport abstraction.

`include/satellite/spacecraft.hpp` — spacecraft execution object that owns a CPU and processes commands.

`include/satellite/ground_station.hpp` — ground command sender and telemetry collector.

`include/satellite/component.hpp` — common lifecycle interface for simulated components.

`include/satellite/subsystem.hpp` — base class for spacecraft subsystems and telemetry ownership.

`include/satellite/fleet.hpp` — registry and scheduler for multiple spacecraft.

`include/satellite/mission_bus.hpp` — fleet-level command/mission abstraction.

`include/satellite/memory.hpp` — word-addressable memory device with technology metadata and patch support.

`include/satellite/patch.hpp` — patch package definition, checksum validation, staging, and application.

`include/satellite/update.hpp` — versioned update-package abstraction.

`include/satellite/config.hpp` — CPU, spacecraft, and fleet configuration structures.

`include/satellite/subsystems/` — power, antenna, thermal, attitude, and radio subsystem implementations.

## Core source

`src/core/cpu.cpp` — implements the virtual instruction decoder/executor and width masking.

`src/core/assembler.cpp` — tokenizes assembly statements and encodes virtual instructions.

`src/core/radio_link.cpp` — schedules packets for delayed delivery.

`src/core/spacecraft.cpp` — executes the flight computer and handles spacecraft commands.

`src/core/ground_station.cpp` — queues ground commands and collects telemetry.

`src/core/fleet.cpp` — advances every registered spacecraft.

`src/core/mission_bus.cpp` — provides the constellation-level command entry point.

`src/core/memory.cpp` — implements virtual persistent/volatile word memory.

`src/core/patch.cpp` — verifies and stages patch words.

`src/core/update.cpp` — stages and validates versioned update packages.

## Assembly

`asm/common/` contains shared constants and source conventions.

`asm/libraries/` contains reusable arithmetic, telemetry, and radio routines.

`asm/sat8`, `asm/sat18`, `asm/sat32`, and `asm/sat64` contain width-specific flight programs.

`asm/fleet/` contains constellation-level routines.

`asm/memory/` contains virtual memory/update controller programs.

`asm/linker/` documents the virtual flight-image layout.

## Ground station

`ground-station/ui/menu.yaml` defines the operator hierarchy.

`ground-station/commands/console.asm` defines the assembly-side command-console loop.

`ground-station/telemetry/grid.yaml` defines the normalized operator telemetry columns.

`ground-station/mission/` documents mission-level views.

`ground-station/satellite/` documents satellite selection.

`ground-station/telemetry/` documents telemetry presentation.

`ground-station/commands/` documents command entry and queueing.

`ground-station/storage/` documents memory/update operations.

`ground-station/comms/` documents link routing.

`ground-station/settings/` documents operator configuration.

## UI/API

`ui/` contains the browser telemetry interface and display concepts.

`ui/tv/` contains CRT and modern-TV display concepts.

`api/openapi.yaml` defines HTTP API endpoints.

`api/schema/telemetry.json` defines normalized telemetry JSON.

## Scenarios

`scenarios/` contains deterministic multi-spacecraft simulation definitions.

## Tests

`tests/` contains CPU, memory, update, and fleet-oriented tests.
