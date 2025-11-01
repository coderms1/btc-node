# 🪙 Bitcoin Node Setup (Fedora / Linux)

**This repository documents the complete setup of a full Bitcoin Core node configured on Fedora Linux, with systemd automation and monitoring scripts.**

## 📘 Overview
- OS: Fedora Linux 41
- Node: Bitcoin Core (bitcoind)
- Wallet Interface: Sparrow Wallet
- Bitcoin Data Path: `/run/home/$USER/.bitcoin`

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

• Displays:
- Block height, verification %, peer count
- Blocks/hour (rolling avg), ETA hours/days
- Visual progress bar (█ = synced)
```
#### 🔐 Wallet (Sparrow)
```
sudo systemctl start sparrow.service   →    Auto-start via systemd
/run/home/$USER/Sparrow/bin/Sparrow    →    Manual launch
Connects locally to your Bitcoin Core node at 127.0.0.1:8332.
```
#### 🧰 CLI & Maintenance
```
bitcoin-cli getblockchaininfo | grep verificationprogress
bitcoin-cli getconnectioncount
sudo systemctl restart bitcoind
df -h | grep bitcoin
htop
sudo systemctl stop bitcoind
```
---

#### 🛰️ Future Plans & Goals

This node is just the start.  
The goal is to expand from a single full Bitcoin Core node into a small network of independently run nodes; 
each monitored, optimized, and synced across different systems and environments, running harmoniously with one another!

• Next steps include: 
```
- Automating backups and remote monitoring  
- Running additional nodes (TAO, Lightning, or archival)  
- Testing resource performance and uptime stability  
- Integrating data from multiple nodes into one dashboard  
```
**🫡 The mission: build a reliable, self-sustaining node network that’s fully transparent, well-documented, and easy to replicate.**


~ *MS1* 🌛
