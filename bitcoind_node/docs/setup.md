# Install Dependencies

sudo dnf update -y
sudo dnf install bitcoin-core git curl jq -y

# Create Data Directory

mkdir -p /run/media/user/location/.bitcoin

# Create Configuration File

Copy and edit configs/bitcoin.conf.example → save as bitcoin.conf
Start Node
bitcoind -daemon -conf=/run/media/user/location/.bitcoin/bitcoin.conf
Enable Auto-start
sudo systemctl enable bitcoind
sudo systemctl start bitcoind

```
Your node will now auto-start on boot and sync from scratch.
```

---

# Common Troubleshooting Commands

## Restart node

```bash
sudo systemctl restart bitcoind
Check logs
journalctl -u bitcoind.service -f
Verify sync
bitcoin-cli getblockchaininfo | grep verificationprogress
Stop node safely
bitcoin-cli stop
```

---

# System Info

- Fedora Linux 41 (Workstation)
- External SSD: 1TB mounted at /run/media/user/location
- Block sync progress: 0.236 → 0.507 over 3 days (total time depends on machine)
- VPN disabled to improve CPU performance (OPTIONAL AND ONLY UNTIL COMPLETE!!!)
- Verified systemctl config for auto-start
