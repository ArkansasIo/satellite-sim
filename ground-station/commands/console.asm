; Ground-station DOS-style command console
BOOT:
    LOAD R0, 1
    OUT R0, 20
LOOP:
    IN R0, 21
    JNZ R0, DISPATCH
    JMP LOOP
DISPATCH:
    OUT R0, 22
    JMP LOOP
