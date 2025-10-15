# 🪙 Bitcoin Node Setup (Fedora / Linux)

This repository documents the complete setup of a full Bitcoin Core node configured on Fedora Linux, with systemd automation and monitoring scripts.

## 📘 Overview
- OS: Fedora Linux 41
- Node: Bitcoin Core (bitcoind)
- Wallet Interface: Sparrow Wallet
- External Drive: `/run/media/user/disk`

---

## ⚙️ Contents
| Folder | Description |
|--------|--------------|
| `systemd/` | Service files for auto-starting node & wallet |
| `configs/` | Example configuration files (no secrets) |
| `scripts/` | Monitoring and maintenance scripts |
| `docs/` | Detailed setup guides, troubleshooting notes |
| `node_build_commands.sh` | Every command used to configure and run the node |

---

## 🚀 Usage
```bash
bash scripts/verify_status.sh
bash scripts/sync_progress.sh
sudo systemctl status bitcoind

# ~ MS1 🌛
