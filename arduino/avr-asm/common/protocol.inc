; satellite-sim AVR protocol constants, version 2.
; Project-defined bench protocol. NOT Voyager/DSN flight encoding.
.equ PROTOCOL_VERSION, 2
.equ CMD_PING, 1
.equ CMD_STATUS, 2
.equ CMD_POWER, 3
.equ CMD_RESET, 4
.equ FRAME_START, 0x7E
.equ FRAME_ESCAPE, 0x7D
.equ FRAME_XOR, 0x20
.equ CMD_BUFFER_SIZE, 64
.equ TLM_BUFFER_SIZE, 64
.equ DEFAULT_POWER, 100
