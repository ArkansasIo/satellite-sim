# Build and Run

## Requirements

- CMake 3.20 or newer
- A C++20-capable compiler (GCC, Clang, or a supported MSVC toolchain)
- Python 3 for project-generator tests

## Configure, build, and test

Linux/macOS:

```sh
cmake -S . -B build
cmake --build build --parallel
ctest --test-dir build --output-on-failure
./build/satellite_sim
```

Windows PowerShell:

```powershell
cmake -S . -B build
cmake --build build --config Release
ctest --test-dir build -C Release --output-on-failure
.\build\Release\satellite_sim.exe
```

## Test the project generator

```sh
python -m unittest discover -s tools/project-generator/tests -p 'test_*.py'
```

## Generate scaffold profiles

```sh
python tools/project-generator/generate.py --profile mvp
python tools/project-generator/generate.py --profile commercial
python tools/project-generator/generate.py --profile extended
```

Generated headers are placeholders, not complete implementations.

## GitHub Pages

This documentation site is built from the Markdown files in `docs/` using MkDocs Material and deployed by GitHub Actions whenever a commit is pushed to `main`. The native C++ simulator itself is not compiled into a browser application by this workflow.

If Pages deployment is not enabled for the repository yet, open **Settings → Pages** and set **Build and deployment → Source** to **GitHub Actions**. Then check the repository's Actions tab for the deployment URL.
