MCU=atmega328p
F_CPU=16000000
AS=avr-as
LD=avr-ld
OBJCOPY=avr-objcopy
SIZE=avr-size

ASFLAGS=-mmcu=$(MCU)
LDFLAGS=-m avr5 -Ttext=0

all: ground_station.hex satellite.hex

ground_station.o: ground_station/main.S common/atmega328p.inc common/protocol.inc
	$(AS) $(ASFLAGS) -o $@ ground_station/main.S

satellite.o: satellite/main.S common/atmega328p.inc common/protocol.inc
	$(AS) $(ASFLAGS) -o $@ satellite/main.S

ground_station.elf: ground_station.o
	$(LD) $(LDFLAGS) -o $@ $<

satellite.elf: satellite.o
	$(LD) $(LDFLAGS) -o $@ $<

ground_station.hex: ground_station.elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

satellite.hex: satellite.elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

size: ground_station.elf satellite.elf
	$(SIZE) $^

clean:
	rm -f *.o *.elf *.hex
