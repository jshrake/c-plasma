# c-plasma  [![main](https://github.com/jshrake/c-plasma/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/jshrake/c-plasma/actions/workflows/main.yml)

Unified* builds of C [libPlasma](https://github.com/zeugma-hamper/plasma/) and associated binaries for various platforms.

|     Platform      | Library  | Binaries  | Yaml  |
|------------------ |:-------: |:--------: |:----: |
| linux (x86-64)    |    ✅     |     ✅     |   ✅   |
| macos (arm64)     |    ✅     |     ✅     |   ✅   |
| xcframework       |    ✅     |     ❌     |   ❌  |
| emscripten        |    ✅     |     ❌     |   ❌   |
| windows (x86-64)  |    ❌     |     ❌    |   ❌   |

\* Unified means that libLoam and libPlasma are built together in a single static library.

The intention of this repo is to make it easy to build language-specific bindings for plasma across multiple platforms by providing pre-built binaries and libraries for just the C API.
