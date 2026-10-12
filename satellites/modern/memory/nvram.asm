; Modern nonvolatile storage abstraction
READ:
    IN R0, 30
    OUT R0, 31
    JMP READ
WRITE:
    IN R0, 32
    OUT R0, 33
    JMP WRITE
