; Magnetic-core-style virtual memory controller
CORE_READ:
    IN R0, 10
    OUT R0, 11
    JMP CORE_READ

CORE_WRITE:
    IN R0, 12
    OUT R0, 13
    JMP CORE_WRITE
