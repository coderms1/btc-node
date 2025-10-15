#!/bin/bash
watch -n 600 "bitcoin-cli getblockcount && bitcoin-cli getblockchaininfo | grep verificationprogress"
