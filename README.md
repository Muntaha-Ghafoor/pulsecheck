# 🩺 PulseCheck

**PulseCheck** is a simple, interactive command-line tool built in Bash that checks whether a target host or IP address is reachable on the network. It wraps the standard `ping` utility in a clean, colorized, and user-friendly interface — making it a great starting point for learning shell scripting and building network utilities.

```
  ____        _          ____ _               _  
 |  _ \ _   _| |___  ___/ ___| |__   ___  ___| | __
 | |_) | | | | / __|/ _ \ |   | '_ \ / _ \/ __| |/ /
 |  __/| |_| | \__ \  __/ |___| | | |  __/ (__|   < 
 |_|    \__,_|_|___/\___|\____|_| |_|\___|\___|_|\_\
```

---

## 📋 Features

- Interactive prompt for target host/IP input
- Sends 4 ICMP ping packets to the target
- Color-coded output — **green** for success, **red** for failure
- Clean ASCII banner interface
- Lightweight — no dependencies beyond standard Bash and `ping`

---

## 🛠️ Requirements

- A Unix-like OS (Linux, macOS, WSL, Kali, etc.)
- Bash shell
- `ping` utility (pre-installed on virtually all systems)

---

## 🚀 Installation

Clone the repository:

```bash
git clone https://github.com/Muntaha-Ghafoor/pulsecheck.git
cd pulsecheck
```

Make the script executable:

```bash
chmod +x pulsecheck.sh
```

---

## ▶️ Usage

Run the script:

```bash
./pulsecheck.sh
```

You'll be prompted to enter a target:

```
Enter your Target: google.com
```

The tool will ping the target 4 times and report whether it's reachable:

```
SUCCESS: google.com is reachable.
```

or

```
FAILED: 192.168.1.999 is NOT reachable.
```

---

## 📂 Project Structure

```
pulsecheck/
├── pulsecheck.sh   # Main script
└── README.md       # Project documentation
```

---

## 🗺️ Roadmap

Planned features for future versions:

- [ ] Menu-driven interface (ping, traceroute, port scan)
- [ ] Accept target as a command-line argument
- [ ] Log results to a file with timestamps
- [ ] Support for scanning multiple targets from a list

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
