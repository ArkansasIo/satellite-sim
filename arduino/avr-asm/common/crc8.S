; CRC-8 helper for protocol framing.
; Polynomial 0x07, initial value 0. Input byte in r24, CRC in r25.
.include "common/atmega328p.inc"

.section .text
.global crc8_update

crc8_update:
    eor r25, r24
    ldi r18, 8
crc_loop:
    lsl r25
    brcc crc_no_xor
    ldi r19, 0x07
    eor r25, r19
crc_no_xor:
    dec r18
    brne crc_loop
    ret
