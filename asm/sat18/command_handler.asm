; 18-bit command decoder
WAIT:
    IN R0, 2
    JNZ R0, HANDLE
    JMP WAIT
HANDLE:
    OUT R0, 3
    JMP WAIT
