#!/bin/bash

echo "================================================"
echo " Attention - Building snarkOS from source code."
echo "================================================"

# Install Ubuntu dependencies

apt-get update
apt-get install -y \
    build-essential \
    curl \
    clang \
    gcc \
    libssl-dev \
    llvm \
    make \
    pkg-config \
    tmux \
    xz-utils
    


# Install Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup default stable
rustup update stable --force
rustup toolchain install nightly-2021-03-10-x86_64-unknown-linux-gnu
toolchain=`rustup toolchain list | grep -m 1 nightly`

# Install snarkOS
# cargo clean
cargo install --path .

echo "=================================================="
echo " Attention - Please ensure ports 4132 and 3032"
echo "             are enabled on your local network."
echo ""
echo " Cloud Providers - Enable ports 4132 and 3032"
echo "                   in your network firewall"
echo ""
echo " Home Users - Enable port forwarding or NAT rules"
echo "              for 4132 and 3032 on your router."
echo "=================================================="

# Open ports on system
ufw allow 4143/tcp
ufw allow 3033/tcp
