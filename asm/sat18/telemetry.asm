; Satellite Sim 18-bit historically inspired example
ORG 0
START:
    LOAD R0, 010
    IN   R1, [R0]
    STORE [100], R1
    HALT
