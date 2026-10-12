# Satellite Sim Architecture

## 1. Shared model

The simulator is divided into six layers:

1. Ground Station
2. Radio Link
3. Spacecraft Command/Telemetry Bus
4. Flight Computer
5. Spacecraft Subsystems
6. Mission State / Physics Model

The same interfaces are shared by both mission profiles.

## 2. CPU abstraction

```
Cpu8  -> 8-bit register/data model
Cpu18 -> historically inspired 18-bit model
Cpu32 -> 32-bit model
Cpu64 -> 64-bit model
```

Each implementation exposes a common instruction, memory, interrupt, and I/O interface. Assembly source is assembled for a selected target.

## 3. Spacecraft subsystems

- Electrical power
- Command and data handling
- Radio communications
- High-gain antenna
- Thermal state
- Attitude/control state
- Instrument/telemetry channels
- Fault injection
- Mission clock

## 4. Bidirectional command path

The ground station creates a command packet. The link simulator applies propagation delay, optional packet loss/corruption, and link state. The spacecraft validates and queues the command. The flight software executes it and emits an acknowledgement or telemetry response.

## 5. Telemetry path

Subsystem state is sampled into telemetry channels, encoded into packets, transmitted through the simulated link, delayed/corrupted as configured, and decoded by the ground station.

## 6. Determinism

A simulation tick is the authoritative unit of state advancement. Randomness must be supplied through a seeded simulation RNG so scenarios can be replayed exactly.
