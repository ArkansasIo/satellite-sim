; 64-bit telemetry
LOOP:
    IN R0, 0
    OUT R0, 3
    IN R1, 1
    OUT R1, 3
    IN R2, 5
    OUT R2, 3
    JMP LOOP
