#!/usr/bin/env bash
# ===========================================
# Bitcoin Node Setup Commands Log
# ===========================================

# Update system and install essentials
sudo dnf update -y
sudo dnf install git wget curl nano jq -y

# Install Bitcoin Core
sudo dnf install bitcoin-core -y

# Verify installation
bitcoind --version
bitcoin-cli --version

# Set up data directory (external drive example)
mkdir -p /run/media/zim/random/.bitcoin
cd /run/media/zim/random/.bitcoin

# Create configuration file
nano bitcoin.conf

# Example configuration (see configs/bitcoin.conf.example)
# datadir=/run/media/zim/random/.bitcoin
# server=1
# daemon=1
# txindex=1
# rpcuser=zimnode
# rpcpassword=<REDACTED>
# rpcallowip=127.0.0.1

# Start the node manually
bitcoind -daemon -conf=/run/media/zim/random/.bitcoin/bitcoin.conf

# Monitor progress
bitcoin-cli getblockchaininfo | grep verificationprogress
bitcoin-cli getblockcount
bitcoin-cli getconnectioncount

# Create systemd service
sudo cp ./systemd/bitcoind.service /etc/systemd/system/
sudo systemctl enable bitcoind.service
sudo systemctl start bitcoind.service
sudo systemctl status bitcoind.service

# Add Sparrow Wallet service (optional)
sudo cp ./systemd/sparrow.service /etc/systemd/system/
sudo systemctl enable sparrow.service
sudo systemctl start sparrow.service

# View logs
sudo journalctl -u bitcoind.service -f
