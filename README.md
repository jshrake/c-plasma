# c-plasma

Builds C libPlasma and associated binaries from <https://github.com/zeugma-hamper/plasma/>.

## Dependencies

```console
$ brew install libyaml
```

## Usage

```console
$ just install
$ tree build/install
build/install
├── bin
│   ├── p-await
│   ├── p-create
│   ├── p-deposit
│   ├── p-info
│   ├── p-newest-idx
│   ├── p-nth
│   ├── p-oldest-idx
│   ├── p-rename
│   ├── p-resize
│   ├── p-sleep
│   ├── p-stop
│   └── pool_tcp_server
├── include
│   ├── libLoam
│   │   └── c
│   │       ├── ob-api.h
│   │       ├── ob-atomic.h
│   │       ├── ob-attrs.h
│   │       ├── ob-coretypes.h
│   │       ├── ob-dirs.h
│   │       ├── ob-file.h
│   │       ├── ob-hash.h
│   │       ├── ob-log.h
│   │       ├── ob-math.h
│   │       ├── ob-mvtypes.h
│   │       ├── ob-rand.h
│   │       ├── ob-retorts.h
│   │       ├── ob-string.h
│   │       ├── ob-thread.h
│   │       ├── ob-time.h
│   │       ├── ob-types.h
│   │       ├── ob-util.h
│   │       └── ob-vers.h
│   └── libPlasma
│       └── c
│           ├── c-plasma.h
│           ├── plasma-retorts.h
│           ├── plasma-types.h
│           ├── pool-time.h
│           ├── pool.h
│           ├── pool_options.h
│           ├── protein.h
│           ├── slaw-coerce.h
│           ├── slaw-io.h
│           ├── slaw-numeric-ilk-rumpus.h
│           ├── slaw-ordering.h
│           ├── slaw-path.h
│           ├── slaw-string.h
│           ├── slaw-walk.h
│           └── slaw.h
└── lib
    ├── libplasma.a
    └── pkgconfig
        └── plasma.pc
```
