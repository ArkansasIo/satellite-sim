# AVR Assembly Build Notes

## GNU AVR assembler

The intended flow is:

```bash
make
make size
```

This produces separate images for the ground-station and satellite prototypes.

## Flashing

Use an appropriate AVR programmer/bootloader workflow for the Uno R3. The exact upload command depends on whether the board is using its normal Arduino bootloader or an external programmer.

Before flashing, verify:
- MCU target is ATmega328P.
- Clock configuration matches the image assumptions.
- Serial wiring is correct.
- The image is the intended ground or satellite role.

## Firmware progression

Current assembly demonstrates:
- stack setup;
- UART initialization;
- UART byte transmit;
- UART byte receive;
- separate ground and satellite images;
- a persistent simulated power variable in the satellite image.

Next implementation layers:
1. ring buffers;
2. interrupt-driven UART;
3. line parser;
4. command sequence parser;
5. CRC/framing;
6. telemetry encoder;
7. watchdog/fault state;
8. EEPROM configuration;
9. deterministic command/telemetry scheduler.

The Arduino C++ sketches remain useful as a higher-level reference implementation while the AVR assembly evolves.
