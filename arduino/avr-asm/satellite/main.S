; satellite-sim AVR Assembly Satellite Node
; Target: Arduino Uno R3 / ATmega328P / 16 MHz
; Firmware role: SAT-ASM embedded spacecraft controller.
;
; This implements a minimal real AVR execution image and a simulated
; power-state register. It intentionally does not claim historical Voyager
; instruction compatibility.

.include "common/atmega328p.inc"
.include "common/protocol.inc"

.section .data
simulated_power:
    .byte DEFAULT_POWER

.section .text
.global main

.equ BAUD_DIV, 103

main:
    ldi r16, high(RAMEND)
    out 0x3e, r16
    ldi r16, low(RAMEND)
    out 0x3d, r16

    rcall uart_init

    ; Configure PB5 / Arduino D13 as a basic status output.
    ldi r16, (1<<DDB5)
    out DDRB, r16

satellite_loop:
    rcall uart_receive
    ; r18 contains the received byte.
    ; The complete line parser is intentionally a subsequent layer;
    ; keeping transport and command parsing separate makes it testable.
    rjmp satellite_loop

uart_init:
    ldi r16, high(BAUD_DIV)
    sts UBRR0H, r16
    ldi r16, low(BAUD_DIV)
    sts UBRR0L, r16
    ldi r16, (1<<RXEN0)|(1<<TXEN0)
    sts UCSR0B, r16
    ldi r16, (1<<UCSZ01)|(1<<UCSZ00)
    sts UCSR0C, r16
    ret

uart_send:
wait_tx:
    lds r16, UCSR0A
    sbrs r16, UDRE0
    rjmp wait_tx
    sts UDR0, r18
    ret

uart_receive:
wait_rx:
    lds r16, UCSR0A
    sbrs r16, RXC0
    rjmp wait_rx
    lds r18, UDR0
    ret
