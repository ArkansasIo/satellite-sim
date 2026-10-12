; Conservative staged update agent
WAIT_PATCH:
    IN R0, 14
    JNZ R0, VERIFY
    JMP WAIT_PATCH
VERIFY:
    IN R1, 15
    JNZ R1, APPLY
    JMP WAIT_PATCH
APPLY:
    OUT R0, 16
    JMP WAIT_PATCH
