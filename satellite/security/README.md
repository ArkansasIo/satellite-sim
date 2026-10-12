# Spacecraft Security

The spacecraft security boundary is independent of human ground-station accounts.

The simulated flight computer uses:
- spacecraft/device identity
- command authentication
- sequence-number replay protection
- command authorization by command class
- integrity checks
- fault-safe rejection
- security event logging
- bounded credential/key storage
- secure boot/update metadata in the simulator model

Human users never transmit their ground-station passwords to the spacecraft.

For the AVR prototype, cryptographic processing is kept bounded and the protocol layer can use a pre-provisioned device key for authenticated simulation frames. Production-grade cryptography requires an appropriate secure implementation and hardware/storage review.
