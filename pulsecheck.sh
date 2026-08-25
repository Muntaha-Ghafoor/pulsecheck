#!/bin/bash
# ---------------------------------------
# PulseCheck - Network Reachability Tool
# ---------------------------------------

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'   # No Color

clear
echo -e "${CYAN}  ____        _          ____ _               _  ${NC}"
echo -e "${CYAN} |  _ \ _   _| |___  ___/ ___| |__   ___  ___| | __${NC}"
echo -e "${CYAN} | |_) | | | | / __|/ _ \ |   | '_ \ / _ \/ __| |/ /${NC}"
echo -e "${CYAN} |  __/| |_| | \__ \  __/ |___| | | |  __/ (__|   < ${NC}"
echo -e "${CYAN} |_|    \__,_|_|___/\___|\____|_| |_|\___|\___|_|\_\\\\${NC}"
echo ""
echo "========================================"
echo "          PULSECHECK v1.0"
echo "     Network Reachability Tool"
echo "========================================"

# Ask the user for input (target host/IP)
read -p "Enter your Target: " target

# Confirm what was entered
echo "You entered: $target"
echo "Pinging $target now..."
echo "----------------------------------------"

# Run the ping command using the variable
ping -c 4 "$target"

# Check if it succeeded or failed
if [ $? -eq 0 ]; then
    echo "----------------------------------------"
    echo -e "${GREEN}SUCCESS: $target is reachable.${NC}"
else
    echo "----------------------------------------"
    echo -e "${RED}FAILED: $target is NOT reachable.${NC}"
fi
