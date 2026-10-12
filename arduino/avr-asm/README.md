# ATmega328P AVR Assembly

This directory contains the low-level assembly counterpart to the Arduino Uno R3 prototype.

## Target

- MCU: ATmega328P
- ISA: 8-bit AVR
- Board: Arduino Uno R3
- CPU clock: 16 MHz
- Ground station firmware: `ground_station/main.S`
- Satellite firmware: `satellite/main.S`
- Shared definitions: `common/atmega328p.inc`, `common/protocol.inc`

The assembly is intended for the microcontroller itself. It does not depend on the Arduino C++ runtime.

## Architecture

```text
Laptop
  |
  | USB serial
  v
Arduino Uno A
MCS-ASM ground firmware
  |
  | UART
  v
Arduino Uno B
SAT-ASM satellite firmware
```

The laptop remains the high-level mission-control computer. The ATmega328P firmware provides deterministic embedded I/O, command parsing, telemetry generation, and the simulated satellite state.

## Toolchain

Recommended GNU AVR toolchain:

- `avr-as`
- `avr-ld`
- `avr-objcopy`
- `avr-size`

The source uses AVR assembler syntax and ATmega328P register definitions. The exact toolchain version should be recorded in build metadata.

## Important limitation

This is a real ATmega328P program, but it is **not Voyager flight software**. The protocol and satellite behavior are project-defined bench simulation behavior.
