# Full Source Map

## CPU and ASM
- include/satellite/cpu.hpp
- src/core/cpu.cpp
- include/satellite/assembler.hpp
- src/core/assembler.cpp
- asm/sat8, asm/sat18, asm/sat32, asm/sat64

## Spacecraft
- spacecraft state
- power subsystem
- antenna state
- command decoder
- flight CPU

## Ground
- command interface
- telemetry collection
- radio-link abstraction

## Verification
- unit tests
- CMake build
- shell/PowerShell demo launchers

The architecture deliberately separates the virtual machine from the mission model so additional CPU widths and hardware models can be added without changing the ground-station protocol.
