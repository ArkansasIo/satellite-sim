; 64-bit command processor
POLL:
    IN R0, 2
    JNZ R0, EXEC
    JMP POLL
EXEC:
    OUT R0, 3
    JMP POLL
