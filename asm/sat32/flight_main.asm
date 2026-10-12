; 32-bit flight executive
BOOT:
    LOAD R0, 1
    OUT R0, 1
LOOP:
    IN R0, 0
    OUT R0, 3
    JMP LOOP
