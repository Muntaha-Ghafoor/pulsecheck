#!/bin/bash
# =========================================================
# PulseCheck v2.0 - Network Reachability & Monitoring Tool
# Author: Muntaha Ghafoor
# =========================================================

# ---- Colors ----
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
BOLD='\033[1m'
NC='\033[0m'

# ---- Config ----
LOGFILE="$HOME/.pulsecheck_history.log"

# ---- Banner ----
banner() {
    clear
    echo -e "${CYAN}  ____        _          ____ _               _  ${NC}"
    echo -e "${CYAN} |  _ \ _   _| |___  ___/ ___| |__   ___  ___| | __${NC}"
    echo -e "${CYAN} | |_) | | | | / __|/ _ \ |   | '_ \ / _ \/ __| |/ /${NC}"
    echo -e "${CYAN} |  __/| |_| | \__ \  __/ |___| | | |  __/ (__|   < ${NC}"
    echo -e "${CYAN} |_|    \__,_|_|___/\___|\____|_| |_|\___|\___|_|\_\\\\${NC}"
    echo ""
    echo "========================================"
    echo -e "        ${BOLD}PULSECHECK v2.0${NC}"
    echo "   Network Reachability & Monitoring"
    echo "========================================"
}

# ---- Logging helper ----
# Usage: log_result "ACTION" "TARGET" "RESULT"
log_result() {
    local action="$1"
    local target="$2"
    local result="$3"
    local ts
    ts=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$ts] [$action] target=$target result=$result" >> "$LOGFILE"
}

pause() {
    echo ""
    read -p "Press Enter to return to the menu..." _
}

# ---- 1. Ping Check ----
ping_check() {
    read -p "Enter target host or IP: " target
    [ -z "$target" ] && { echo -e "${RED}No target entered.${NC}"; pause; return; }

    echo -e "${CYAN}Pinging $target...${NC}"
    echo "----------------------------------------"
    ping -c 4 "$target"
    status=$?
    echo "----------------------------------------"

    if [ $status -eq 0 ]; then
        echo -e "${GREEN}SUCCESS: $target is reachable.${NC}"
        log_result "PING" "$target" "SUCCESS"
    else
        echo -e "${RED}FAILED: $target is NOT reachable.${NC}"
        log_result "PING" "$target" "FAILED"
    fi
    pause
}

# ---- 2. Traceroute ----
traceroute_check() {
    read -p "Enter target host or IP: " target
    [ -z "$target" ] && { echo -e "${RED}No target entered.${NC}"; pause; return; }

    if ! command -v traceroute >/dev/null 2>&1; then
        echo -e "${RED}traceroute is not installed. Install it with: sudo apt install traceroute${NC}"
        log_result "TRACEROUTE" "$target" "TOOL_MISSING"
        pause
        return
    fi

    echo -e "${CYAN}Tracing route to $target...${NC}"
    echo "----------------------------------------"
    traceroute "$target"
    status=$?
    echo "----------------------------------------"

    if [ $status -eq 0 ]; then
        echo -e "${GREEN}Traceroute completed.${NC}"
        log_result "TRACEROUTE" "$target" "COMPLETED"
    else
        echo -e "${RED}Traceroute failed.${NC}"
        log_result "TRACEROUTE" "$target" "FAILED"
    fi
    pause
}

# ---- 3. Port Check ----
port_check() {
    read -p "Enter target host or IP: " target
    read -p "Enter port number(s) [e.g. 22 or 22,80,443]: " ports_input
    [ -z "$target" ] || [ -z "$ports_input" ] && { echo -e "${RED}Target and port are required.${NC}"; pause; return; }

    echo "----------------------------------------"

    # Split on commas, trim spaces, loop over each port
    IFS=',' read -ra PORT_LIST <<< "$ports_input"
    for raw_port in "${PORT_LIST[@]}"; do
        port=$(echo "$raw_port" | tr -d '[:space:]')
        [ -z "$port" ] && continue

        if ! [[ "$port" =~ ^[0-9]+$ ]]; then
            echo -e "${YELLOW}SKIPPED: '$port' is not a valid port number.${NC}"
            continue
        fi

        echo -e "${CYAN}Checking port $port on $target...${NC}"
        if timeout 3 bash -c "cat < /dev/null > /dev/tcp/$target/$port" 2>/dev/null; then
            echo -e "${GREEN}OPEN: Port $port on $target is open.${NC}"
            log_result "PORT_CHECK" "$target:$port" "OPEN"
        else
            echo -e "${RED}CLOSED: Port $port on $target is closed or filtered.${NC}"
            log_result "PORT_CHECK" "$target:$port" "CLOSED"
        fi
    done

    echo "----------------------------------------"
    pause
}

# ---- 4. Monitor Mode ----
monitor_mode() {
    read -p "Enter target host or IP to monitor: " target
    [ -z "$target" ] && { echo -e "${RED}No target entered.${NC}"; pause; return; }
    read -p "Check interval in seconds [default 5]: " interval
    interval=${interval:-5}

    echo -e "${CYAN}Monitoring $target every ${interval}s. Press CTRL+C to stop.${NC}"
    echo "----------------------------------------"
    log_result "MONITOR_START" "$target" "STARTED"

    last_state=""
    trap 'echo -e "\n${YELLOW}Monitoring stopped by user.${NC}"; log_result "MONITOR_STOP" "$target" "STOPPED"; pause; return' INT

    while true; do
        ts=$(date "+%Y-%m-%d %H:%M:%S")
        if ping -c 1 -W 2 "$target" > /dev/null 2>&1; then
            state="UP"
            color=$GREEN
        else
            state="DOWN"
            color=$RED
        fi

        echo -e "${color}[$ts] $target is $state${NC}"

        if [ "$state" != "$last_state" ]; then
            log_result "MONITOR" "$target" "STATUS_CHANGED_TO_$state"
            last_state="$state"
        fi

        sleep "$interval"
    done
}

# ---- 5. Bulk Scan ----
bulk_scan() {
    read -p "Enter path to host list file (one host per line): " filepath

    if [ -z "$filepath" ] || [ ! -f "$filepath" ]; then
        echo -e "${RED}File not found: $filepath${NC}"
        pause
        return
    fi

    # Strip blank lines and comments (#) from the file
    mapfile -t hosts < <(grep -vE '^\s*(#|$)' "$filepath")

    total=${#hosts[@]}
    if [ "$total" -eq 0 ]; then
        echo -e "${YELLOW}No valid hosts found in $filepath.${NC}"
        pause
        return
    fi

    echo -e "${CYAN}Scanning $total host(s) from $filepath...${NC}"
    echo "----------------------------------------"

    up_count=0
    down_count=0
    declare -a up_hosts=()
    declare -a down_hosts=()

    for host in "${hosts[@]}"; do
        host=$(echo "$host" | tr -d '[:space:]')
        [ -z "$host" ] && continue

        if ping -c 2 -W 2 "$host" > /dev/null 2>&1; then
            echo -e "${GREEN}UP    $host${NC}"
            up_count=$((up_count + 1))
            up_hosts+=("$host")
            log_result "BULK_SCAN" "$host" "UP"
        else
            echo -e "${RED}DOWN  $host${NC}"
            down_count=$((down_count + 1))
            down_hosts+=("$host")
            log_result "BULK_SCAN" "$host" "DOWN"
        fi
    done

    echo "----------------------------------------"
    echo -e "${BOLD}Bulk Scan Summary${NC}"
    echo "----------------------------------------"
    echo -e "Total hosts checked : $total"
    echo -e "${GREEN}Reachable (UP)       : $up_count${NC}"
    echo -e "${RED}Unreachable (DOWN)   : $down_count${NC}"

    if [ "$down_count" -gt 0 ]; then
        echo ""
        echo -e "${RED}Down hosts:${NC}"
        for h in "${down_hosts[@]}"; do
            echo "  - $h"
        done
    fi

    log_result "BULK_SCAN_SUMMARY" "$filepath" "UP=$up_count DOWN=$down_count TOTAL=$total"
    pause
}

# ---- 6. View History ----
view_history() {
    echo "----------------------------------------"
    if [ -f "$LOGFILE" ]; then
        tail -n 30 "$LOGFILE"
    else
        echo -e "${YELLOW}No history yet. Run a check first.${NC}"
    fi
    echo "----------------------------------------"
    pause
}

# ---- Main Menu ----
main_menu() {
    while true; do
        banner
        echo ""
        echo "  1) Ping Check"
        echo "  2) Traceroute"
        echo "  3) Port Check"
        echo "  4) Monitor Mode (live, repeated checks)"
        echo "  5) Bulk Scan (scan a list of hosts from a file)"
        echo "  6) View History"
        echo "  7) Exit"
        echo ""
        read -p "Select an option [1-7]: " choice

        case "$choice" in
            1) ping_check ;;
            2) traceroute_check ;;
            3) port_check ;;
            4) monitor_mode ;;
            5) bulk_scan ;;
            6) view_history ;;
            7) echo -e "${CYAN}Goodbye!${NC}"; exit 0 ;;
            *) echo -e "${RED}Invalid option.${NC}"; pause ;;
        esac
    done
}

main_menu
