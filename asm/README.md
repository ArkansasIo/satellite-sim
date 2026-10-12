# Assembly Targets

The simulator supports one assembly source model with width-specific target definitions.

Targets:

- `sat8`
- `sat18`
- `sat32`
- `sat64`

Example:

```asm
; telemetry.asm
START:
    LOAD R0, TELEMETRY_CHANNEL
    IN   R1, [R0]
    STORE [TELEMETRY_BUFFER], R1
    HALT
```

The exact instruction encoding belongs to the virtual CPU target and is not intended to reproduce undocumented flight hardware.
