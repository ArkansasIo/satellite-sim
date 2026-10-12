; SAT-ASM command parser layer.
; Consumes a compact framed command and dispatches a small allowlist.
; This file is intentionally structured so the parser can later be unit-tested
; against the same protocol contract as the C++/Arduino implementation.

.include "common/atmega328p.inc"
.include "common/protocol.inc"

.section .text
.global command_dispatch

command_dispatch:
    ; r24 = command identifier
    ; r22 = argument/value
    ; Return r24 = 0 on success, 1 on rejected command.
    cpi r24, CMD_PING
    breq command_ok
    cpi r24, CMD_STATUS
    breq command_ok
    cpi r24, CMD_POWER
    breq command_power
    cpi r24, CMD_RESET
    breq command_reset
    ldi r24, 1
    ret

command_power:
    cpi r22, 101
    brlo command_ok
    ldi r24, 1
    ret

command_reset:
    ; A real implementation would enter a controlled reset state.
    ; Do not jump to address zero from an unvalidated external command.
    rjmp command_ok

command_ok:
    clr r24
    ret
