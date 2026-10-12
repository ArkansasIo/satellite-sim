; Satellite Sim 8-bit example
ORG 0x0000
START:
    LOAD R0, 0x10
    IN   R1, [R0]
    STORE [0x80], R1
    HALT
