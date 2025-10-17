#!/bin/bash
# ============================================================
#  Bitcoin Node Progress Tracker
#  Tracks current block height, verifies progress,
#  estimates blocks/hour, hrs & days remaining.
# ============================================================

# --- Configuration ---
tip_block=880000                      
rate_file=~/sync_log.txt   # <--- log file for block history

# --- Collect current data ---
current_block=$(bitcoin-cli getblockcount 2>/dev/null)
progress=$(bitcoin-cli getblockchaininfo 2>/dev/null | grep verificationprogress | awk '{print $2}' | tr -d ',')
remaining=$((tip_block - current_block))

# --- Compute rate ---
if [ -f "$rate_file" ]; then
    last_block=$(tail -n 3 "$rate_file" | head -n 1)
    last_time=$(stat -c %Y "$rate_file")
    now=$(date +%s)
    elapsed=$((now - last_time))
    if [ "$elapsed" -gt 0 ]; then
        blocks_per_hour=$(( (current_block - last_block) * 3600 / elapsed ))
    else
        blocks_per_hour=0
    fi
else
    echo "📘 First run — logging baseline. Run again later for ETA."
    blocks_per_hour=0
fi

# --- Estimate remaining time ---
eta_hours=0
if [ "$blocks_per_hour" -gt 0 ]; then
    eta_hours=$(( remaining / blocks_per_hour ))
fi

# --- Display results ---
echo "============================================="
echo "🧱 Block Height:        $current_block / $tip_block"
echo "⚡ Blocks/hour:         $blocks_per_hour"
echo "🕒 Hours left (est):    $eta_hours"
echo "📅 Days left (est):     $(awk -v h="$eta_hours" 'BEGIN {printf "%.1f", h/24}')"
echo "📈 Verification Progress: $progress"
echo "============================================="

# --- Log new data for next run ---
{
  echo "$current_block"
  echo "$(date)"
} >> "$rate_file"

# --- Make it executable ---
chmod +x nodes_progress.sh

# --- Run it anytime ---
./nodes_progress.sh