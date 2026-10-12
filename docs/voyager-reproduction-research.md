# Voyager Computer Reproduction: Research Notes

**Research date:** 2026-10-11  
**Scope:** A simulation grounded in public historical sources, not a claim to reproduce every detail of the operational Voyager flight software.

## Executive finding

A faithful Voyager simulation must not model the spacecraft as one generic 18-bit CPU. NASA describes three computer types, with two units of each type: the Computer Command System (CCS), Flight Data System (FDS), and Attitude and Articulation Control System (AACS). CCS is an 18-bit, interrupt-oriented computer with 4,096 words of plated-wire nonvolatile memory per unit; FDS is a 16-bit machine; AACS is an 18-bit machine with 4,096 words per unit. The architecture should therefore represent six computer instances grouped into three subsystem pairs, while permitting subsystem-focused fidelity to be implemented incrementally. [1]

## Publicly documented architecture

### Computer Command System (CCS)
NASA's FAQ describes CCS as an 18-bit interrupt-type processor with 4,096 words of plated-wire nonvolatile memory per computer. Its functions include interpreting ground instructions, sequencing spacecraft activities, commanding other subsystems, and responding to faults. The same source describes fixed routines and a variable area used for changeable science sequences. [1]

### Flight Data System (FDS)
NASA describes FDS as a 16-bit machine with modular memory. Its responsibilities include collecting data from science instruments, controlling instrument operations, formatting engineering and science data, and supporting onboard time/frequency references. [1][2]

The public FDS emulator repository documents a reconstructed implementation with a 16-bit word, 12-bit address, 4-bit opcode format, two 4K banks (8K words total), special registers, serial/parallel I/O, DMA channels, and a periodic interrupt. These are useful implementation leads, but emulator README claims are secondary sources and should be cross-checked against the referenced JPL architecture and functional-requirements documents before being treated as validated requirements. [3]

### Attitude and Articulation Control System (AACS)
NASA describes AACS as an 18-bit computer system that controls spacecraft orientation, antenna pointing, maneuvers, and scan-platform articulation. [1][2]

## Timing and communications

NASA's mission description states that onboard sequences can run for long periods without continuous real-time intervention. Sequence duration depends on available sequence memory and mission activity; published cruise examples reach multiple weeks. [4] The simulation should therefore model stored command sequences and time-driven execution, not only instantaneous remote commands.

Deep-space communication must be represented as delayed. The simulator should parameterize signal propagation delay and link availability instead of hard-coding one timeless “Voyager delay”; actual delay changes with spacecraft-Earth distance and epoch.

## Recommended fidelity levels

1. **Level 1 — architecture model:** model the three subsystem types, redundant pairs, command routing, telemetry, and communication delay.
2. **Level 2 — FDS instruction-set emulator:** implement the publicly described 16-bit instruction set, registers, memory banking, I/O, DMA and periodic interrupt behavior, with tests against published examples.
3. **Level 3 — CCS/AACS behavioral models:** implement only behaviors supported by public documentation; mark unknown firmware details as modeled assumptions.
4. **Level 4 — integrated mission simulator:** run onboard sequences, fault-protection scenarios, instrument data flows, telemetry formatting, and redundant-unit selection.
5. **Level 5 — validation:** compare outputs to published instruction examples, document-derived test vectors, and publicly available mission/telemetry products where formats and provenance are known.

## What cannot responsibly be claimed

- The existing project's generic 18-bit virtual CPU is not the actual Voyager CCS or AACS ISA.
- The FDS is not 18-bit; NASA describes it as a 16-bit machine. [1]
- A public emulator is evidence of a useful reconstruction, not proof that it matches every revision of flight hardware or all flight software.
- A faithful CPU emulator is not equivalent to reproducing the spacecraft's complete flight software, hardware timing, analog electronics, sensors, radio, or mission operations.
- Do not copy third-party emulator source code without reviewing its license and provenance. Prefer a clean-room implementation from public technical documents, with attribution and tests.

## Sources

1. NASA Science, “Frequently Asked Questions — Voyager”: urlNASA Voyager FAQturn0search0
2. NASA Science, “Voyager Spacecraft”: urlNASA Voyager spacecraft overviewturn0search2
3. Zane Hambly, “Voyager FDS Emulator” (secondary implementation and source references): urlVoyager FDS emulator repositoryturn0search8
4. NASA Science, “Voyager Science — Sequencing Strategy”: urlNASA Voyager sequencing strategyturn0search3
5. NASA technical history, “Computers in Spaceflight: The NASA Experience,” FDS architecture discussion: urlNASA technical history PDFturn0search10
6. NASA/PDS, “Voyager Mission Description”: urlVoyager mission description in NASA PDSturn0search1
7. Zane Hambly, hardware implementation/repository overview: urlVoyager FDS hardware projectturn0search6

## Source-quality note

NASA/PDS and JPL-origin technical material are the primary baseline. Community emulators and research archives are useful for finding instruction details and transcriptions but should be cross-checked against primary documents. This document records the research baseline, not a completed validation of every instruction or every hardware revision.
