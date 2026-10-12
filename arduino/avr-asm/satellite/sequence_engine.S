; SAT-ASM onboard sequence engine boundary.
; A sequence is a deterministic list of time-tagged actions.
; This module intentionally contains no historical Voyager command IDs.
.include "common/atmega328p.inc"

.section .data
sequence_enabled: .byte 0
sequence_index: .byte 0

.section .text
.global sequence_start
.global sequence_stop
.global sequence_step

sequence_start:
    ldi r24, 1
    sts sequence_enabled, r24
    clr r24
    sts sequence_index, r24
    ret

sequence_stop:
    clr r24
    sts sequence_enabled, r24
    ret

sequence_step:
    lds r24, sequence_enabled
    tst r24
    breq sequence_done
    lds r24, sequence_index
    inc r24
    sts sequence_index, r24
sequence_done:
    ret
