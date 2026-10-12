# Satellite Sim

A virtual deep-space spacecraft and ground-station simulation platform.

## Implemented

- 8-bit, 18-bit, 32-bit and 64-bit virtual CPU targets
- Width-masked registers and memory
- Assembly parser/encoder with a compact instruction set
- Telemetry and command I/O ports
- Bidirectional delayed radio-link simulation
- Virtual spacecraft command processing
- Power and antenna state
- Ground-station command and telemetry API
- Voyager-style and modern mission profiles
- C++20 build with CMake
- Unit/integration-oriented executable tests
- Linux/macOS shell launcher and Windows PowerShell launcher

## Source tree

```
asm/
  sat8/ sat18/ sat32/ sat64/       Assembly examples

include/satellite/
  types.hpp                         Shared protocol/types
  cpu.hpp                           Virtual CPU API
  assembler.hpp                     ASM assembler API
  radio_link.hpp                    Link simulator API
  spacecraft.hpp                    Spacecraft API
  ground_station.hpp                Ground station API

src/core/
  cpu.cpp
  assembler.cpp
  radio_link.cpp
  spacecraft.cpp
  ground_station.cpp

src/main.cpp                         Runnable simulation demo
tests/test_main.cpp                  CPU + assembler verification

missions/
  voyager-style/                     Historical-inspired profile
  modern/                            Current-technology profile

protocols/                            Command/telemetry definitions
ground-station/                       Ground console architecture
sim/                                   Simulation architecture
docs/                                  Architecture/protocol/file map
tools/                                 Build and demo launchers
```

## CPU model

The simulator deliberately uses an abstract CPU ABI rather than claiming that the real Voyager spacecraft used this exact instruction set. The 18-bit target is a historically inspired emulation profile; 8-bit, 32-bit and 64-bit targets provide scalable virtual hardware.

## Simulation flow

Ground command → radio-link delay → spacecraft command decoder → flight CPU/ASM → spacecraft subsystems → telemetry → radio-link delay → ground station.

## Build

```bash
cmake -S . -B build
cmake --build build
ctest --test-dir build --output-on-failure
./build/satellite_sim
```

Windows PowerShell:

```powershell
.\tools\run_demo.ps1
```

## Next implementation layer

The architecture is ready for a richer instruction set, memory-mapped spacecraft hardware, fault injection, deterministic mission replay, packet serialization, a graphical ground-control console, and more detailed historical/current hardware profiles.
