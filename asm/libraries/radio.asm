; Radio helpers
READ_COMMAND:
    IN R0, 2
    JMP R15
WRITE_TELEMETRY:
    OUT R0, 3
    JMP R15
