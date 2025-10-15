#!/bin/bash
bitcoin-cli getblockchaininfo | grep verificationprogress
bitcoin-cli getconnectioncount
bitcoin-cli getblockcount