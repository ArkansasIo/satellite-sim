; Legacy-style persistent memory controller
READ:
    IN R0, 10
    OUT R0, 11
    JMP READ
WRITE:
    IN R0, 12
    OUT R0, 13
    JMP WRITE
