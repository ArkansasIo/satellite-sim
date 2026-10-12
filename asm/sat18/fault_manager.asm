; 18-bit fault monitor
FAULT_LOOP:
    IN R0, 5
    JNZ R0, SAFE
    JMP FAULT_LOOP
SAFE:
    LOAD R1, 0
    OUT R1, 1
    JMP FAULT_LOOP
