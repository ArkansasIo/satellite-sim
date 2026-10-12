# Virtual Assembly Reference

## Instruction encoding

The virtual CPU uses a 64-bit container for instruction words, then masks registers, memory, immediates, and I/O values to the configured CPU width.

Instruction families:

- `NOP` — no operation
- `LOAD Rn, imm` — load immediate
- `ADD Rn, Rm` — integer addition
- `SUB Rn, Rm` — integer subtraction
- `AND`, `OR`, `XOR` — bitwise operations
- `JMP address` — unconditional branch
- `JNZ Rn, address` — conditional branch
- `IN Rn, port` — input port read
- `OUT Rn, port` — output port write
- `HALT` — stop execution

## Register model

The virtual CPU exposes 16 general-purpose registers. Register zero through register fifteen are addressed by the assembly syntax `R0` through `R15`.

## Widths

8-bit, 18-bit, 32-bit, and 64-bit modes use the same conceptual instruction set. Width changes the representable word range and masking behavior.

## Example

```asm
START:
    LOAD R0, 1
    OUT R0, 1
LOOP:
    IN R0, 0
    OUT R0, 3
    JMP LOOP
```

This is a simulator ISA, not a reproduction of an actual historical flight instruction set.
