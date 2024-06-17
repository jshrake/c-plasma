# c-plasma  [![main](https://github.com/jshrake/c-plasma/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/jshrake/c-plasma/actions/workflows/main.yml)

Pre-built static libraries of C [plasma](https://github.com/zeugma-hamper/plasma/) for various platforms. You can find the build artifacts in the [latest release](https://github.com/jshrake/c-plasma/releases/tag/v0.0.5).

|     Platform      | Library  | Binaries    | Yaml  |
|------------------ |:-------: |:----------: |:----: |
| linux (x86-64)    |    ✅     |     ✅     |   ✅  |
| macos (arm64)     |    ✅     |     ✅     |   ✅  |
| ios               |    ✅     |     ❌     |   ❌  |
| windows (x86-64)  |    ❌     |     ❌     |   ❌  |

The goal of this repo is to make it easy to build language-specific bindings for plasma across multiple platforms by combining C libLoam and libPlasma into a single pre-built static library.
