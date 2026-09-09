<div align="center">

# 🩺 PulseCheck

**An interactive, menu-driven Bash tool for network reachability, monitoring, and diagnostics.**

[![License: MIT](https://img.shields.io/badge/License-MIT-3DDC84.svg)](LICENSE)
![Shell: Bash](https://img.shields.io/badge/Shell-Bash-1F6FEB.svg)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20WSL-333.svg)

</div>

```
  ____        _          ____ _               _  
 |  _ \ _   _| |___  ___/ ___| |__   ___  ___| | __
 | |_) | | | | / __|/ _ \ |   | '_ \ / _ \/ __| |/ /
 |  __/| |_| | \__ \  __/ |___| | | |  __/ (__|   < 
 |_|    \__,_|_|___/\___|\____|_| |_|\___|\___|_|\_\
```

PulseCheck wraps everyday network diagnostics — ping, traceroute, port scanning, live monitoring, and bulk host checks — into a single, color-coded, menu-driven command-line tool. Every check is automatically logged with a timestamp, so you get a real history of network activity, not just a one-off result.

---

## 📋 Features

| Feature | Description |
|---|---|
| 🟢 **Ping Check** | Test if a single host or IP is reachable |
| 🛰️ **Traceroute** | Trace the network path to a target, hop by hop |
| 🔌 **Port Check** | Check one or multiple ports at once (e.g. `22,80,443`) |
| 📡 **Monitor Mode** | Continuously watch a host and report live UP/DOWN status changes |
| 📂 **Bulk Scan** | Scan a whole list of hosts from a file, with a summary report |
| 🕒 **History Log** | Every check is saved with a timestamp to `~/.pulsecheck_history.log` |

All results use color-coded output — 🟩 green for success, 🟥 red for failure, 🟨 yellow for warnings.

---

## 🛠️ Requirements

- A Unix-like OS (Linux, macOS, WSL, Kali, etc.)
- Bash shell
- `ping` (pre-installed on virtually all systems)
- `traceroute` *(optional — install with `sudo apt install traceroute` if missing)*

---

## 🚀 Installation

### Option 1 — One-line install (recommended)

```bash
curl -sSL https://raw.githubusercontent.com/Muntaha-Ghafoor/pulsecheck/main/install.sh | bash
```

This installs PulseCheck as a system-wide command. Run it from anywhere with:

```bash
pulsecheck
```

### Option 2 — Clone the repository

```bash
git clone https://github.com/Muntaha-Ghafoor/pulsecheck.git
cd pulsecheck
chmod +x pulsecheck.sh
./pulsecheck.sh
```

---

## 🧭 Step-by-Step: How to Use This Repo

Follow these steps from scratch — no prior setup needed.

### Step 1 — Get the code onto your machine

**Either** install with one command:
```bash
curl -sSL https://raw.githubusercontent.com/Muntaha-Ghafoor/pulsecheck/main/install.sh | bash
```

**Or** clone the repository manually:
```bash
git clone https://github.com/Muntaha-Ghafoor/pulsecheck.git
cd pulsecheck
```

### Step 2 — Make the script executable

*(Skip this step if you used the one-line installer — it's already handled.)*

```bash
chmod +x pulsecheck.sh
```

### Step 3 — Run the tool

```bash
./pulsecheck.sh
```
*(If you used the one-line installer instead, just run `pulsecheck` from anywhere.)*

### Step 4 — Choose an option from the menu

```
  1) Ping Check
  2) Traceroute
  3) Port Check
  4) Monitor Mode (live, repeated checks)
  5) Bulk Scan (scan a list of hosts from a file)
  6) View History
  7) Exit
```
Type the number of the option you want and press **Enter**.

### Step 5 — Follow the on-screen prompts

Each option asks for what it needs:
- **Ping Check / Traceroute** → asks for one target (host or IP)
- **Port Check** → asks for a target, then one or more ports (e.g. `22,80,443`)
- **Monitor Mode** → asks for a target and a check interval in seconds; press `CTRL+C` to stop
- **Bulk Scan** → asks for the path to a text file listing hosts (see example below)

### Step 6 — Review the result

Results appear directly in the terminal with color-coded status:
- 🟩 Green = success / reachable / open
- 🟥 Red = failure / unreachable / closed
- 🟨 Yellow = warning (e.g. missing tool, invalid input)

### Step 7 — Check your history anytime

Every check you run is saved automatically. To see your recent activity:
- Select **Option 6 (View History)** from the menu, **or**
- View the raw log file directly:
```bash
cat ~/.pulsecheck_history.log
```

### Step 8 — Exit when done

Select **Option 7 (Exit)** from the menu, or press `CTRL+C` at any time.

---

## 📸 Usage Examples

### Example — Port Check (multiple ports)

```
Enter target host or IP: google.com
Enter port number(s) [e.g. 22 or 22,80,443]: 22,443
```

### Example — Bulk Scan

Create a text file with one host per line:

```
# hosts.txt
8.8.8.8
google.com
192.168.1.1
```

Select **Bulk Scan** and provide the file path (e.g. `hosts.txt`). PulseCheck scans each host and prints a summary:

```
Total hosts checked : 3
Reachable (UP)       : 2
Unreachable (DOWN)   : 1
```

### Example — Monitor Mode

Continuously pings a target at a set interval and logs only when its status changes (UP → DOWN or DOWN → UP). Stop anytime with `CTRL+C`.

---

## 📂 Project Structure

```
pulsecheck/
├── pulsecheck.sh       # Main tool
├── install.sh          # One-line installer script
├── hosts.example.txt   # Sample host list for Bulk Scan
├── LICENSE             # MIT License
└── README.md           # Project documentation
```

---

## 🗺️ Roadmap

- [ ] JSON/CSV export of scan results
- [ ] Config file for saving frequently-checked hosts
- [ ] ASCII latency graph for Monitor Mode
- [ ] Desktop notifications on host status change

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome. Feel free to check the [issues page](https://github.com/Muntaha-Ghafoor/pulsecheck/issues) or submit a pull request.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👤 Author

**Muntaha Ghafoor**
*Cybersecurity Student & Security Automation Developer*

- GitHub: [@Muntaha-Ghafoor](https://github.com/Muntaha-Ghafoor)
- LinkedIn: [muntaha-ghafoor](https://www.linkedin.com/in/muntaha-ghafoor-2b87a9386)

---

<div align="center">

*If you found this project useful, consider giving it a ⭐ on GitHub!*

</div>
