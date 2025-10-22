# 🪙 Bitcoin Node Setup (Fedora / Linux)

**This repository documents the complete setup of a full Bitcoin Core node configured on Fedora Linux, with systemd automation and monitoring scripts.**

## 📘 Overview
- OS: Fedora Linux 41
- Node: Bitcoin Core (bitcoind)
- Wallet Interface: Sparrow Wallet
- External Drive: `/run/media/user/disk`

---

## ⚙️ Contents
| Folder     | Description                                   |
|------------|-----------------------------------------------|
| `systemd/` | Service files for auto-starting node & wallet |
| `configs/` | Example configuration files (no secrets)      |
| `scripts/` | Building, monitoring and maintenance scripts  |
| `docs/`    | Detailed setup guides, troubleshooting notes  |

---

## 🚀 Usage

### 🧱 Node Control
```
sudo systemctl start bitcoind       →  Start node
sudo systemctl stop bitcoind        →  Stop node safely
sudo systemctl enable bitcoind      →  Auto-start on boot
sudo systemctl status bitcoind      →  Check status
tail -f ~/.bitcoin/debug.log        →  View live logs
```
#### 💾 Sync Monitoring
```
./scripts/node_progress.sh                →   Show current sync stats
watch -n 600 ./scripts/node_progress.sh   →   Auto-refresh every 10 min
Displays:

- Block height, verification %, peer count
- Blocks/hour (rolling avg), ETA hours/days
- Visual progress bar (█ = synced)
```
#### 🔐 Wallet (Sparrow)
```
sudo systemctl start sparrow.service        →    Auto-start via systemd
/run/media/user/disk/Sparrow/bin/Sparrow    →    Manual launch
Connects locally to your Bitcoin Core node at 127.0.0.1:8332.
```
#### 🧰 CLI & Maintenance
```
bitcoin-cli getblockchaininfo | grep verificationprogress
bitcoin-cli getconnectioncount
sudo systemctl restart bitcoind
df -h | grep bitcoin
htop
sudo systemctl stop bitcoind && sudo umount /run/media/user/disk
```
---

~ *MS1* 🌛
