; SAT-ASM fault manager.
; Fault policy is conservative: invalid commands are rejected and a fault
; flag can be latched for telemetry. No automatic actuator behavior is implied.
.include "common/atmega328p.inc"

.section .data
fault_flags:
    .byte 0

.section .text
.global fault_set
.global fault_clear
.global fault_get

fault_set:
    ; r24 = mask
    lds r25, fault_flags
    or r25, r24
    sts fault_flags, r25
    ret

fault_clear:
    ; r24 = mask
    com r24
    lds r25, fault_flags
    and r25, r24
    sts fault_flags, r25
    ret

fault_get:
    lds r24, fault_flags
    ret
