# Arduino Uno R3 Ground Station + Satellite Prototype

Target: two Arduino Uno R3 boards based on the ATmega328P. Each has a 16 MHz clock, 32 KB flash, 2 KB SRAM, and 1 KB EEPROM. The sketches are deliberately small because the board's RAM is very limited. See the official [Arduino Uno R3 documentation](https://docs.arduino.cc/hardware/uno-rev3/).

## Board roles

- `ground_station/ground_station.ino`: USB serial command console; accepts STATUS, PING, HELP, and POWER n from the host Serial Monitor.
- `satellite/satellite.ino`: simulated satellite node; receives a compact command protocol and returns telemetry.

This is an educational embedded prototype, not real spacecraft hardware or a Voyager-compatible flight computer. The node's POWER value is simulated state, not a physical power-system measurement.

## First bench test

1. Open the ground-station sketch in Arduino IDE and upload it to board A.
2. Open the satellite sketch and upload it to board B.
3. Connect the boards with a common ground and cross the UART lines through a safe 5 V TTL serial connection: ground station TX (D11) to satellite RX (D10), ground station RX (D10) to satellite TX (D11), and GND to GND. Do not connect both boards' USB host connections through their UART pins; keep each board powered/programmed via its own USB and use the separate UART pins.
4. Set the ground station serial monitor to 115200 baud. The satellite software UART uses 9600 baud.
5. Type `PING`, `STATUS`, or `POWER 75` into the ground station USB serial monitor.

The sketches use SoftwareSerial on D10/D11 to keep USB Serial available for the operator console. On each board, SoftwareSerial uses D10 as RX and D11 as TX; wire the two boards' D11-to-D10 and D10-to-D11 crossed.

## Protocol

Line-oriented ASCII:
- Uplink: `CMD,<sequence>,PING`
- Uplink: `CMD,<sequence>,STATUS`
- Uplink: `CMD,<sequence>,POWER,<0..100>`
- Downlink: `TLM,<sequence>,PONG`
- Downlink: `TLM,<sequence>,STATUS,<power>,<uptime_ms>`
- Downlink: `TLM,<sequence>,POWER,<power>`
- Downlink: `ERR,<sequence>,<reason>`

This bench protocol is a project-defined demonstration protocol, not a historical Voyager or DSN format. It has no RF link, cryptographic authentication, robust framing checksum, or radiation protection. Do not use it to control safety-critical hardware.
