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

2. at that time you got your package generated
```bash
└── dist
    └── hello-world-1-2.el9.noarch.rpm
```

3. access container to verify package
Container by default doesn't run systemd on PID 1 which will make service test fail. Use `rockylinux/rockylinux:9-ubi-init` to get it proper.

```bash
docker run -d \
  --name hello-world \
  --privileged \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -v $(pwd)/dist:/rpms \
  rockylinux/rockylinux:9-ubi-init
```