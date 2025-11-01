#!/bin/bash
# Use this if you want an update every 10 minutes. 
# If you've build the node_progress.sh script this may be redundant...up to you!
watch -n 600 "bitcoin-cli getblockcount && bitcoin-cli getblockchaininfo | grep verificationprogress"
