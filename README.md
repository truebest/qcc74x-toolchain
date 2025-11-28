# QCC74x Toolchain Docker Image

Docker image with pre-installed RISC-V toolchain for QCC74x microcontroller development.

## Why Docker?

The QCC74x RISC-V toolchain is only available for Linux x86_64. This Docker image allows you to:

- **macOS users**: Compile firmware without a Linux VM
- **Windows users**: Build using WSL2 or Docker Desktop
- **Linux ARM users**: Cross-compile on Apple Silicon or Raspberry Pi via emulation
- **CI/CD**: Reproducible builds in GitHub Actions, GitLab CI, etc.

No need to install or configure the toolchain manually — just pull and compile.

## Features

- Ubuntu 24.04 base
- RISC-V GCC toolchain (`riscv64-unknown-elf-gcc`)
- Build tools: make, cmake, ninja-build
- Ready for QCC743/QCC744 firmware development

## Quick Start

### Use as Native Compiler (Recommended)

Create a wrapper script to use the Docker toolchain like a native compiler:

```bash
#!/bin/bash
docker run --rm --platform linux/amd64 -v "$(pwd)":/workspace -w /workspace cubicattache/qcc74x-toolchain:latest riscv64-unknown-elf-gcc "$@"
```

Save it as `riscv64-unknown-elf-gcc`, then:

```bash
chmod +x riscv64-unknown-elf-gcc
sudo mv riscv64-unknown-elf-gcc /usr/local/bin/
```

Now use it like a native compiler:

```bash
riscv64-unknown-elf-gcc -c main.c -o main.o
riscv64-unknown-elf-gcc --version
```

### Direct Docker Usage

```bash
# Pull the image
docker pull cubicattache/qcc74x-toolchain:latest

# Compile a C file
docker run --rm -v $(pwd):/workspace -w /workspace cubicattache/qcc74x-toolchain:latest \
    riscv64-unknown-elf-gcc -c main.c -o main.o

# Interactive shell
docker run --rm -it -v $(pwd):/workspace -w /workspace cubicattache/qcc74x-toolchain:latest /bin/bash
```

## Toolchain Info

| Tool | Path |
|------|------|
| GCC | `/opt/toolchain/bin/riscv64-unknown-elf-gcc` |
| G++ | `/opt/toolchain/bin/riscv64-unknown-elf-g++` |
| Objcopy | `/opt/toolchain/bin/riscv64-unknown-elf-objcopy` |
| Size | `/opt/toolchain/bin/riscv64-unknown-elf-size` |

All tools are in `PATH` by default.

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `CHIP` | qcc743 | Target chip |
| `BOARD` | qcc743dk | Target board |

## Links

- [QCC74x SDK Repository](https://git.codelinaro.org/clo/qcc7xx/QCCSDK-QCC74x)
