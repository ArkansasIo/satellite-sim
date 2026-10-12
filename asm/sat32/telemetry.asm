; Satellite Sim 32-bit example
ORG 0x00000000
START:
    LOAD R0, 0x00000010
    IN   R1, [R0]
    STORE [0x00000080], R1
    HALT
