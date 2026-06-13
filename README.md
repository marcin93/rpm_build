# RPM dummy package build

## Description
This is dummy repo suppose dto document RPM package creation as of 2026.06

Build does use container to build RPM.

Structure:
```bash
.
├── Dockerfile
├── README.md
├── SOURCES
│   ├── hello-world-1
│   │   ├── hello-world.conf
│   │   ├── hello-world.service
│   │   └── hello-world.sh
│   └── hello-world-1.tar.gz
├── SPECS
│   └── hello-world.spec
├── build.sh
└── dist
    └── hello-world-1-2.el9.noarch.rpm
```

## Build

0. install docker/podman

1. create RPM
```bash
./build.sh
```