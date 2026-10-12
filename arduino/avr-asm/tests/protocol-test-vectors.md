# AVR Protocol Test Vectors

These are project-defined software tests, not historical Voyager test vectors.

## CRC-8

Polynomial: 0x07  
Initial CRC: 0x00

The implementation contract is:
- input byte in AVR register r24;
- prior CRC in r25;
- result returned in r25.

## Command identifiers

| ID | Command |
|---:|---|
| 1 | PING |
| 2 | STATUS |
| 3 | POWER |
| 4 | RESET |

POWER accepts 0 through 100 inclusive.

## Fault behavior

Unknown commands must return rejection status. POWER values above 100 must be rejected. External RESET must not directly jump to address zero from an unvalidated parser path.
