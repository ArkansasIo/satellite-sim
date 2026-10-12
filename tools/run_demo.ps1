$ErrorActionPreference = "Stop"
cmake -S . -B build
cmake --build build
ctest --test-dir build --output-on-failure
& .\build\satellite_sim.exe
