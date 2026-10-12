# Voyager Reproduction Plan

## Objective

Add a distinct Voyager-inspired computer/spacecraft model beside the existing generic virtual CPU. Preserve the existing multi-satellite platform while introducing subsystem-specific emulation behind clear interfaces.

## Proposed repository layout

```text
voyager/
  README.md
  docs/
    source-register.md
    fidelity-matrix.md
  include/voyager/
    word.hpp
    fds_cpu.hpp
    fds_memory.hpp
    fds_io.hpp
    fds_dma.hpp
    interrupt_controller.hpp
    ccs_model.hpp
    aacs_model.hpp
    redundant_pair.hpp
  src/
    fds_cpu.cpp
    fds_memory.cpp
    fds_io.cpp
    fds_dma.cpp
    interrupt_controller.cpp
    ccs_model.cpp
    aacs_model.cpp
    redundant_pair.cpp
  asm/fds/
  tests/
    test_fds_cpu.cpp
    test_fds_banking.cpp
    test_fds_io.cpp
    test_fds_interrupts.cpp
```

This is a proposed subsystem and should be added without replacing `include/satellite/cpu.hpp`, whose generic ISA remains useful for non-historical spacecraft profiles.

## Implementation phases

### Phase A — source inventory and ISA contract
- Record each primary source, revision/date, page number, and the exact requirement it supports.
- Extract the FDS opcode table, instruction encoding, addressing rules, register map, bank switching, skip/branch behavior, I/O, DMA, and interrupt behavior.
- Keep unresolved/contradictory details in an explicit uncertainty list.

### Phase B — FDS CPU core
- Use a 16-bit word type and explicit 12-bit address representation where the documented architecture requires it.
- Model the documented register and special-register behavior rather than assuming a modern register file.
- Implement instruction-by-instruction execution with trace records.
- Implement defined overflow, skip, and branch behavior from the reference documentation.
- Do not implement an opcode based solely on a guess from its mnemonic.

### Phase C — memory and timing
- Implement bank selection and the special-register address region.
- Separate instruction-cycle accounting from host wall-clock time.
- Make clock frequency configurable and document whether execution timing is instruction-accurate, cycle-accurate, or approximate.
- Model periodic interrupts only after period, priority, and service behavior are sourced.

### Phase D — I/O and DMA
- Create device interfaces for serial and parallel ports.
- Model DMA as explicit transfers with channel priority and status.
- Connect simulated instrument/storage/radio endpoints through adapters.
- Test ordering, busy state, completion, and fault conditions.

### Phase E — CCS and AACS
- Implement behaviorally documented command/sequence and attitude-control functions.
- Model each redundant pair as two independent units plus an explicit selector/switchover policy.
- Avoid inventing internal firmware or undocumented opcode semantics.

### Phase F — mission integration
- Connect ground commands and telemetry to the existing delayed link abstraction.
- Support queued onboard sequences that continue during communication gaps.
- Emit telemetry with source subsystem, timestamp, sequence counter, quality, and provenance.
- Run deterministic mission scenarios and preserve event logs.

## Fidelity matrix

| Area | Target | Evidence required | Initial status |
|---|---|---|---|
| Computer types | CCS 18-bit, FDS 16-bit, AACS 18-bit | NASA system descriptions | Documented baseline |
| Redundancy | Two instances of each type | NASA FAQ | Documented baseline |
| FDS ISA | Full documented instruction set | JPL architecture specification | Research/implementation required |
| FDS banking | Exact bank semantics | JPL FDS architecture documentation | Must verify |
| Interrupts | Exact timing and semantics | Primary technical document | Must verify |
| DMA | Channel behavior and priority | FDS functional requirements | Must verify |
| CCS firmware | Historically accurate routines | Flight software descriptions/listings | Incomplete public evidence |
| AACS behavior | Publicly documented control functions | Mission documents | Behavioral model first |
| Mission behavior | Stored sequences, fault responses | NASA/JPL descriptions and telemetry | Incremental validation |
| Physical analog behavior | Sensors, power, RF, actuators | Hardware specifications | Simplified unless separately sourced |

## Acceptance criteria

- Each implemented instruction has a citation or document/page reference in the instruction table.
- Unknown semantics fail explicitly or remain unimplemented; they must not silently behave as another instruction.
- CPU tests cover all instruction families, bank transitions, branch/skip rules, and exceptional states.
- Deterministic tests validate DMA and interrupt ordering.
- An end-to-end scenario demonstrates command delay, onboard execution while out of contact, and later telemetry downlink.
- Documentation distinguishes measured facts, sourced facts, derived calculations, and simulation assumptions.
