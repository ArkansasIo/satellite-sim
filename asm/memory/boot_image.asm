; Persistent boot image manager
BOOT:
    IN R0, 16
    JNZ R0, BOOT_OK
    JMP BOOT
BOOT_OK:
    OUT R0, 17
    HALT
