# Command Lifecycle

1. **Draft:** operator or scenario creates a command sequence with target and arguments.
2. **Validate:** check schema, command identifier, argument ranges, target profile, sequence order, and time tags. Rules must come from the configured simulated command dictionary.
3. **Review:** show validation results and explicit approval state. The simulator must not imply that approval is a historical Voyager procedure unless supported by a cited source.
4. **Package:** assign immutable product ID, version, checksum, creation time, and provenance.
5. **Schedule:** associate the product with a simulated station contact and transmit time.
6. **Queue:** retain the product if no station contact is available.
7. **Transmit:** emit command events only when the station and link are operational.
8. **Propagate:** apply configurable light-time before the spacecraft can receive the command.
9. **Execute:** the simulated CCS/spacecraft model accepts, rejects, or executes the command according to its documented behavior model.
10. **Confirm:** record acknowledgement or later telemetry evidence; do not assume transmission implies execution.
11. **Archive:** preserve all product versions and every state transition for replay and audit.

Every transition should record a timestamp from the deterministic mission clock, prior state, new state, actor/service, and reason.
