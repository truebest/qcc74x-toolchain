FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    git make gcc g++ cmake ninja-build \
    python3 python3-pip pkg-config \
    libglib2.0-dev libssl-dev flex bison \
    device-tree-compiler bc cpio file \
    && rm -rf /var/lib/apt/lists/*

# Copy toolchain into image
COPY toolchain/linux_x86_64 /opt/toolchain
ENV PATH="/opt/toolchain/bin:${PATH}"

WORKDIR /workspace
