# 🩺 PulseCheck

**PulseCheck** is an interactive, menu-driven command-line tool built in Bash for checking network reachability, tracing routes, scanning ports, monitoring hosts live, and scanning multiple targets at once — all with color-coded output and persistent history logging.

```
  ____        _          ____ _               _  
 |  _ \ _   _| |___  ___/ ___| |__   ___  ___| | __
 | |_) | | | | / __|/ _ \ |   | '_ \ / _ \/ __| |/ /
 |  __/| |_| | \__ \  __/ |___| | | |  __/ (__|   < 
 |_|    \__,_|_|___/\___|\____|_| |_|\___|\___|_|\_\
```

---

## 📋 Features

| Feature | Description |
|---|---|
| **Ping Check** | Test if a single host or IP is reachable |
| **Traceroute** | Trace the network path to a target, hop by hop |
| **Port Check** | Check one or multiple ports at once (e.g. `22,80,443`) |
| **Monitor Mode** | Continuously watch a host and report live UP/DOWN status changes |
| **Bulk Scan** | Scan a whole list of hosts from a file, with a summary report |
| **History Log** | Every check is saved with a timestamp to `~/.pulsecheck_history.log` |

All results use color-coded output — green for success, red for failure, yellow for warnings.

---

## 🛠️ Requirements

- A Unix-like OS (Linux, macOS, WSL, Kali, etc.)
- Bash shell
- `ping` (pre-installed on virtually all systems)
- `traceroute` (optional — install with `sudo apt install traceroute` if missing)

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

## ▶️ Usage

Run the script and choose an option from the menu:

```
  1) Ping Check
  2) Traceroute
  3) Port Check
  4) Monitor Mode (live, repeated checks)
  5) Bulk Scan (scan a list of hosts from a file)
  6) View History
  7) Exit
```

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
Then select **Bulk Scan** and provide the file path (e.g. `hosts.txt`). PulseCheck scans each host and prints a summary:
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
├── pulsecheck.sh   # Main tool
├── install.sh      # One-line installer script
└── README.md       # Project documentation
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

- GitHub: [@Muntaha-Ghafoor](https://github.com/Muntaha-Ghafoor)
- LinkedIn: [muntaha-ghafoor](https://www.linkedin.com/in/muntaha-ghafoor-2b87a9386)

---

*If you found this project useful, consider giving it a ⭐ on GitHub!*
