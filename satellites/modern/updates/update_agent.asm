; Versioned modern update agent
WAIT:
    IN R0, 34
    JNZ R0, VERIFY
    JMP WAIT
VERIFY:
    IN R1, 35
    JNZ R1, COMMIT
    JMP WAIT
COMMIT:
    OUT R0, 36
    JMP WAIT
