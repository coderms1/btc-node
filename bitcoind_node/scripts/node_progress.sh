#!/bin/bash
# =================================================================
#  Bitcoin Node ~ Progress Tracker (v3.0)
#  Tracks current block height, verifies progress, connections,
#  averages blocks/hour, & estimates hours & days remaining.
# =================================================================

# ---=== Configuration ===---
DATA_FILE="$HOME/.bitcoin/node_progress_data.txt"
HISTORY_FILE="$HOME/.bitcoin/node_progress_history.txt"
MAX_SAMPLES=5
TARGET_BLOCK=880000

# ---=== Colors ===---
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# ---=== Header ===---
echo -e "${CYAN}🟢 Node Progress — $(date)${RESET}"

# --- Collect current data ---
CURRENT_BLOCK=$(bitcoin-cli getblockcount)
INFO=$(bitcoin-cli getblockchaininfo)
VERIFICATION=$(echo "$INFO" | grep -o '"verificationprogress":[^,]*' | cut -d: -f2)
CONNECTIONS=$(bitcoin-cli getconnectioncount)

# ---=== Compute rate ===---
if [ -f "$DATA_FILE" ]; then
    LAST_BLOCK=$(head -n 1 "$DATA_FILE")
    LAST_TIME=$(tail -n 1 "$DATA_FILE")
    CURRENT_TIME=$(date +%s)
    TIME_DIFF=$((CURRENT_TIME - LAST_TIME))
    BLOCK_DIFF=$((CURRENT_BLOCK - LAST_BLOCK))

    if [ $TIME_DIFF -gt 0 ]; then
        BLOCKS_PER_HOUR=$(echo "scale=2; ($BLOCK_DIFF / $TIME_DIFF) * 3600" | bc)
        echo "$BLOCK_DIFF $TIME_DIFF" >> "$HISTORY_FILE"
    else
        BLOCKS_PER_HOUR=0
    fi
else
    echo -e "${YELLOW}📘 First run — creating data file...${RESET}"
    BLOCKS_PER_HOUR=0
    BLOCK_DIFF=0
fi

# --- Maintain rolling history ---
if [ -f "$HISTORY_FILE" ]; then
    LINE_COUNT=$(wc -l < "$HISTORY_FILE")
    if [ "$LINE_COUNT" -gt "$MAX_SAMPLES" ]; then
        tail -n "$MAX_SAMPLES" "$HISTORY_FILE" > "${HISTORY_FILE}.tmp" && mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
    fi

    TOTAL_BLOCKS=0
    TOTAL_TIME=0
    while read -r BD TD; do
        TOTAL_BLOCKS=$((TOTAL_BLOCKS + BD))
        TOTAL_TIME=$((TOTAL_TIME + TD))
    done < "$HISTORY_FILE"

    if [ $TOTAL_TIME -gt 0 ]; then
        AVG_BLOCKS_PER_HOUR=$(echo "scale=2; ($TOTAL_BLOCKS / $TOTAL_TIME) * 3600" | bc)
    else
        AVG_BLOCKS_PER_HOUR=0
    fi
else
    AVG_BLOCKS_PER_HOUR=$BLOCKS_PER_HOUR
fi

# ---=== Estimate remaining time ===---
REMAINING=$((TARGET_BLOCK - CURRENT_BLOCK))
if (( $(echo "$AVG_BLOCKS_PER_HOUR > 0" | bc -l) )); then
    HOURS_LEFT=$(echo "scale=2; $REMAINING / $AVG_BLOCKS_PER_HOUR" | bc)
    DAYS_LEFT=$(echo "scale=2; $HOURS_LEFT / 24" | bc)
else
    HOURS_LEFT=0
    DAYS_LEFT=0
fi

# ---=== Save data for next run ===---
{
  echo "$CURRENT_BLOCK"
  date +%s
} > "$DATA_FILE"

# ---=== Display results ===---
echo "============================================================"
echo -e "${GREEN}🧱 Block Height:${RESET}          $CURRENT_BLOCK / $TARGET_BLOCK"
echo -e "${GREEN}📈 Verification Progress:${RESET} $VERIFICATION"
echo -e "${GREEN}🌐 Connections:${RESET}           $CONNECTIONS peers"
echo -e "${YELLOW}⚡ Blocks Since Last Check:${RESET} $BLOCK_DIFF"
echo -e "${YELLOW}📊 Avg Blocks/Hour:${RESET}       $AVG_BLOCKS_PER_HOUR"
echo -e "${YELLOW}🕒 Hours Left (est):${RESET}      $HOURS_LEFT"
echo -e "${YELLOW}📅 Days Left (est):${RESET}       $DAYS_LEFT"
echo "============================================================"
