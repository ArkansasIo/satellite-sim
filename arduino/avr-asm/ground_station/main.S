; satellite-sim AVR Assembly Ground Station
; Target: Arduino Uno R3 / ATmega328P / 16 MHz
; Firmware role: MCS-ASM embedded command bridge.
;
; USB-serial laptop protocol is intentionally kept minimal here.
; A production version should add framing, CRC, timeout/retry,
; command allowlisting and robust parser recovery.

.include "common/atmega328p.inc"
.include "common/protocol.inc"

.section .text
.global main

; 16 MHz / 9600 baud:
; UBRR = F_CPU/(16*baud)-1 ~= 103.
.equ BAUD_DIV, 103

main:
    ; Initialize stack.
    ldi r16, high(RAMEND)
    out 0x3e, r16
    ldi r16, low(RAMEND)
    out 0x3d, r16

    rcall uart_init
    rcall send_banner

main_loop:
    ; Embedded bridge loop.
    ; A full implementation would read the laptop command stream,
    ; validate it, and forward a framed command to the satellite UART.
    rcall uart_receive
    rjmp main_loop

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
    ; r18 = byte to transmit.
wait_tx:
    lds r16, UCSR0A
    sbrs r16, UDRE0
    rjmp wait_tx
    sts UDR0, r18
    ret

uart_receive:
    ; Blocking receive of one byte into r18.
wait_rx:
    lds r16, UCSR0A
    sbrs r16, RXC0
    rjmp wait_rx
    lds r18, UDR0
    ret

send_banner:
    ldi r18, 'M'
    rcall uart_send
    ldi r18, 'C'
    rcall uart_send
    ldi r18, 'S'
    rcall uart_send
    ldi r18, '-'
    rcall uart_send
    ldi r18, 'A'
    rcall uart_send
    ldi r18, 'S'
    rcall uart_send
    ldi r18, 'M'
    rcall uart_send
    ldi r18, 13
    rcall uart_send
    ldi r18, 10
    rcall uart_send
    ret
