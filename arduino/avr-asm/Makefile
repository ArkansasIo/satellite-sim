MCU=atmega328p
F_CPU=16000000
AS=avr-as
LD=avr-ld
OBJCOPY=avr-objcopy
SIZE=avr-size
ASFLAGS=-mmcu=$(MCU)
LDFLAGS=-m avr5 -Ttext=0

all: ground_station.hex satellite.hex

ground_station.o:
	$(AS) $(ASFLAGS) -o $@ ground_station/main.S

SAT_OBJECTS=satellite.o command_parser.o telemetry.o scheduler.o cron.o sequence_engine.o fault_manager.o watchdog.o crc8.o

satellite.o:
	$(AS) $(ASFLAGS) -o $@ satellite/main.S
command_parser.o:
	$(AS) $(ASFLAGS) -o $@ satellite/command_parser.S
telemetry.o:
	$(AS) $(ASFLAGS) -o $@ satellite/telemetry.S
scheduler.o:
	$(AS) $(ASFLAGS) -o $@ satellite/scheduler.S
cron.o:
	$(AS) $(ASFLAGS) -o $@ satellite/cron.S
sequence_engine.o:
	$(AS) $(ASFLAGS) -o $@ satellite/sequence_engine.S
fault_manager.o:
	$(AS) $(ASFLAGS) -o $@ satellite/fault_manager.S
watchdog.o:
	$(AS) $(ASFLAGS) -o $@ satellite/watchdog.S
crc8.o:
	$(AS) $(ASFLAGS) -o $@ common/crc8.S

ground_station.elf: ground_station.o
	$(LD) $(LDFLAGS) -o $@ $^

satellite.elf: $(SAT_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

ground_station.hex: ground_station.elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

satellite.hex: satellite.elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

size: ground_station.elf satellite.elf
	$(SIZE) $^

clean:
	rm -f *.o *.elf *.hex
