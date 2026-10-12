# Build Information Interface

The build-information interface is available conceptually from both the CLI and operator UI.

## CLI

    satellite-sim --version
    satellite-sim --build-info
    satellite-sim --credits

## Operator UI

Help -> About -> Build Information
Help -> About -> Credits

Build Information should display product/version, model versions, API/protocol versions, Git revision, compiler, platform, architecture, and build configuration.

Credits should display project development credits, historical research sources, and third-party dependency attribution.

## Machine-readable metadata

The build system should generate runtime-readable metadata containing product, version, Git commit, UTC build timestamp, compiler, compiler version, platform, architecture, API version, simulator protocol version, Voyager model version, and ground-system model version.

Generated values must come from the build environment rather than being manually edited for every build.
