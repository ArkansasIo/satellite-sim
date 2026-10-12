; 18-bit deep-space executive
RESET:
    LOAD R0, 1
    OUT R0, 1
MAIN:
    IN R0, 0
    OUT R0, 3
    IN R1, 1
    OUT R1, 3
    JMP MAIN
