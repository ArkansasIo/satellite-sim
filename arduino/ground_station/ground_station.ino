/*
 * satellite-sim Arduino Ground Station Node
 * Target: Arduino Uno R3 / ATmega328P
 * Version: 0.1.0
 *
 * USB Serial is the operator console (115200 baud).
 * SoftwareSerial D10/D11 is the simulated spacecraft link (9600 baud).
 * Protocol is a project demo protocol, not historical Voyager command encoding.
 */
#include <SoftwareSerial.h>
#include <string.h>
#include <stdlib.h>

static const uint8_t LINK_RX_PIN = 10;
static const uint8_t LINK_TX_PIN = 11;
static const unsigned long CONSOLE_BAUD = 115200;
static const unsigned long LINK_BAUD = 9600;
static const size_t LINE_CAPACITY = 80;

SoftwareSerial spacecraftLink(LINK_RX_PIN, LINK_TX_PIN);
char consoleLine[LINE_CAPACITY];
char telemetryLine[LINE_CAPACITY];
size_t consoleLength = 0;
size_t telemetryLength = 0;
uint16_t nextSequence = 1;

void printHelp() {
  Serial.println(F("satellite-sim Arduino Ground Station v0.1.0"));
  Serial.println(F("Commands: HELP | PING | STATUS | POWER <0..100>"));
  Serial.println(F("Link: SoftwareSerial D10=RX D11=TX at 9600 baud"));
}

void sendCommand(const char *verb, int value, bool hasValue) {
  const uint16_t sequence = nextSequence++;
  spacecraftLink.print(F("CMD,"));
  spacecraftLink.print(sequence);
  spacecraftLink.print(',');
  spacecraftLink.print(verb);
  if (hasValue) {
    spacecraftLink.print(',');
    spacecraftLink.print(value);
  }
  spacecraftLink.print('\n');

  Serial.print(F("[UPLINK] seq="));
  Serial.print(sequence);
  Serial.print(F(" command="));
  Serial.println(verb);
}

void processConsoleLine(char *line) {
  while (*line == ' ' || *line == '\t') ++line;
  if (strcmp(line, "HELP") == 0 || strcmp(line, "help") == 0) {
    printHelp();
  } else if (strcmp(line, "PING") == 0 || strcmp(line, "ping") == 0) {
    sendCommand("PING", 0, false);
  } else if (strcmp(line, "STATUS") == 0 || strcmp(line, "status") == 0) {
    sendCommand("STATUS", 0, false);
  } else if (strncmp(line, "POWER ", 6) == 0 || strncmp(line, "power ", 6) == 0) {
    const long value = strtol(line + 6, NULL, 10);
    if (value < 0 || value > 100) {
      Serial.println(F("[ERROR] POWER must be between 0 and 100"));
      return;
    }
    sendCommand("POWER", (int)value, true);
  } else if (*line != '\0') {
    Serial.println(F("[ERROR] Unknown command. Type HELP."));
  }
}

void pollConsole() {
  while (Serial.available() > 0) {
    const char c = (char)Serial.read();
    if (c == '\r') continue;
    if (c == '\n') {
      consoleLine[consoleLength] = '\0';
      processConsoleLine(consoleLine);
      consoleLength = 0;
    } else if (consoleLength < LINE_CAPACITY - 1) {
      consoleLine[consoleLength++] = c;
    } else {
      consoleLength = 0;
      Serial.println(F("[ERROR] Console line too long; discarded"));
    }
  }
}

void pollTelemetry() {
  while (spacecraftLink.available() > 0) {
    const char c = (char)spacecraftLink.read();
    if (c == '\r') continue;
    if (c == '\n') {
      telemetryLine[telemetryLength] = '\0';
      if (telemetryLength > 0) {
        Serial.print(F("[DOWNLINK] "));
        Serial.println(telemetryLine);
      }
      telemetryLength = 0;
    } else if (telemetryLength < LINE_CAPACITY - 1) {
      telemetryLine[telemetryLength++] = c;
    } else {
      telemetryLength = 0;
      Serial.println(F("[ERROR] Telemetry line too long; discarded"));
    }
  }
}

void setup() {
  Serial.begin(CONSOLE_BAUD);
  spacecraftLink.begin(LINK_BAUD);
  Serial.println(F("\n[MCS-UNO] Booting ground station node..."));
  Serial.println(F("[VLINK] UART link initialized; awaiting operator command."));
  printHelp();
}

void loop() {
  pollConsole();
  pollTelemetry();
}
