# Human Development Team Structure

## Scenario A — 5–7 Person MVP

### Core team

1. **Technical Lead / Systems Engineer**
   - Owns architecture and technical roadmap.
   - Coordinates spacecraft, ground, data, and protocol boundaries.
   - Maintains engineering standards.

2. **C++ / Simulation Engineer**
   - CPU emulator.
   - Spacecraft models.
   - Mission clock.
   - Fleet simulation.
   - Deterministic tests.

3. **Backend / Database Engineer**
   - Ground APIs.
   - MySQL schema.
   - Telemetry archive.
   - Command service.
   - Authentication integration.

4. **Frontend / UI Engineer**
   - Mission-control console.
   - Satellite inspector.
   - Telemetry views.
   - CRT/terminal presentation.
   - Modern display modes.

5. **Embedded / AVR Engineer**
   - Arduino Uno R3.
   - ATmega328P assembly.
   - UART/framing.
   - EEPROM/fixed-record storage.
   - Watchdog and scheduler.

6. **QA / DevOps Engineer (optional MVP role)**
   - CI.
   - Integration testing.
   - Packaging.
   - Deployment.
   - Regression testing.

7. **Part-time domain specialist (optional)**
   - Aerospace/mission operations review.
   - Telemetry and command semantics.
   - Historical Voyager fidelity review.

## Scenario B — 12–20 Person Commercial Team

The commercial organization separates the disciplines instead of combining them.

### Systems
- Chief architect.
- Mission-systems/aerospace specialist.

### Simulation
- 2 C++ engineers.

### Embedded
- 2 embedded/firmware engineers.

### Platform
- 2 backend/database engineers.
- 2 frontend/UI engineers.

### Data and operations
- 1 telemetry/data engineer.
- 1 DevOps/cloud engineer.

### Security
- 1 security engineer.

### Quality
- 2 QA/test automation engineers.

### Product and documentation
- 1 product/project manager.
- 1 technical writer.

This produces a nominal 17-person organization and leaves room to scale to 20 with additional QA, backend, or embedded specialists.

## Engineering ownership

| Area | Primary owner | Secondary |
|---|---|---|
| Architecture | Technical lead | Aerospace specialist |
| CPU/simulation | C++ team | QA |
| Spacecraft models | C++ team | Systems |
| AVR | Embedded | QA |
| Telemetry | Data engineer | Backend |
| Ground API | Backend | Security |
| UI | Frontend | Product |
| Authentication | Security | Backend |
| Database | Backend | Data |
| CI/deployment | DevOps | QA |
| Mission workflows | Systems | Product |
| Documentation | Technical writer | All teams |

## Staffing principle

Do not hire 17 people before the architecture is validated. The recommended path is 5–7 people first, followed by staged hiring based on demonstrated workload and product requirements.
