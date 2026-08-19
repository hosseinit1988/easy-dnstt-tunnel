# 🚀 Easy DNSTT Tunnel

<p align="center">
  <strong>A professional one-command installer for DNSTT Tunnel + 3x-UI</strong><br>
  <sub>Automated setup • DNS tunneling • Firewall configuration • SSL • Management Panel</sub>
</p>

<p align="center">
  <a href="https://github.com/hosseinit1988/easy-dnstt-tunnel">
    <img src="https://img.shields.io/github/stars/hosseinit1988/easy-dnstt-tunnel?style=for-the-badge&logo=github" alt="GitHub Stars">
  </a>
  <a href="https://github.com/hosseinit1988/easy-dnstt-tunnel/issues">
    <img src="https://img.shields.io/github/issues/hosseinit1988/easy-dnstt-tunnel?style=for-the-badge&logo=github" alt="GitHub Issues">
  </a>
  <img src="https://img.shields.io/badge/Linux-Ubuntu%20%7C%20Debian-orange?style=for-the-badge&logo=linux" alt="Linux">
  <img src="https://img.shields.io/badge/Shell-Bash-green?style=for-the-badge&logo=gnu-bash" alt="Bash">
  <img src="https://img.shields.io/badge/DNSTT-1.5.1-blue?style=for-the-badge" alt="DNSTT">
  <img src="https://img.shields.io/badge/3x--ui-Integrated-purple?style=for-the-badge" alt="3x-ui">
</p>

---

## 📌 Overview

**Easy DNSTT Tunnel** is a Bash-based automation script designed to simplify the deployment of a DNSTT tunnel server together with the **3x-ui** management panel.

Instead of manually installing packages, configuring the firewall, downloading DNSTT, generating keys, creating a systemd service, installing 3x-ui, and requesting SSL certificates, the script guides you through the setup using an interactive terminal interface.

The project is intended for Linux administrators, network engineers, developers, and advanced users who want a repeatable deployment workflow.

> **Project:** `hosseinit1988/easy-dnstt-tunnel`  
> **Main script:** `DNSTT-Tunnel.sh`

---

## ✨ Features

| Feature | Description |
|---|---|
| 🚀 Automated installation | Installs and configures the main components interactively |
| 🌐 DNSTT server | Downloads and configures DNSTT Server |
| 🔐 Key generation | Generates the DNSTT server key pair automatically |
| ⚙️ systemd integration | Creates and enables a dedicated `dnstt.service` |
| 🛡️ UFW firewall | Opens the required network ports automatically |
| 🎛️ 3x-ui | Installs the 3x-ui management panel |
| 🔒 SSL support | Uses Certbot to request TLS certificates |
| 🧰 Prerequisites | Installs required command-line packages |
| 🖥️ Interactive UI | Colored terminal interface with progress indicators |
| 📋 Configuration summary | Shows the selected domain, tunnel domain, IP and SSL email |
| 🔎 Service status | Displays DNSTT service state after installation |
| 📖 DNS guidance | Provides an interactive DNS configuration guide |

---

## 🧠 How It Works

At a high level, the deployment looks like this:

```text
                    ┌──────────────────────┐
                    │      Your Client     │
                    │  DNS / Tunnel Client │
                    └──────────┬───────────┘
                               │
                               │ DNS Queries
                               ▼
                    ┌──────────────────────┐
                    │   Recursive Resolver │
                    └──────────┬───────────┘
                               │
                               │ DNS Delegation
                               ▼
                    ┌──────────────────────┐
                    │    DNSTT Server      │
                    │      UDP/TCP 53      │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │      Server OS       │
                    │   Ubuntu / Debian    │
                    └──────────────────────┘
```

DNSTT is an application-layer DNS tunnel. The upstream DNSTT project describes its protocol as using DNS transport with KCP/smux and Noise encryption, and it can operate through standard UDP DNS as well as DoH/DoT depending on the client implementation.

---

## 🧩 Components

### DNSTT

The script downloads:

```text
dnstt-server v1.5.1
```

and installs it under:

```text
/opt/dnstt/
```

A key pair is generated for the configured tunnel domain.

### 3x-ui

The installer also invokes the official 3x-ui installation script:

```bash
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
```

The panel is configured for access through TCP port:

```text
2053
```

> **Important:** 3x-ui is a separate project and is not developed by this repository.

### systemd

The DNSTT server is registered as:

```text
dnstt.service
```

It is configured to start automatically after boot and restart automatically if the process exits.

---

# 🛠️ Requirements

## Supported Operating Systems

The current script checks for:

- Ubuntu
- Debian

The script requires **root privileges**.

Recommended environment:

```text
Linux VPS
Public IPv4 address
Root / sudo access
A registered domain
DNS management access
```

A clean server is strongly recommended.

---

## 🌐 Domain & DNS Configuration

Before running the installer, prepare your DNS records.

Assume:

```text
Main domain: example.com
DNS tunnel:  dns.example.com
Server IP:   203.0.113.10
```

The script's built-in DNS guide uses the following structure:

### A Record

```text
Type:   A
Name:   ns
Value:  YOUR_SERVER_IP
Proxy:  DNS Only
```

Example:

```text
ns.example.com → 203.0.113.10
```

### NS Record

```text
Type:   NS
Name:   dns
Value:  ns.example.com
```

Example:

```text
dns.example.com → ns.example.com
```

### ⚠️ Cloudflare

If you use Cloudflare, the DNS records used by the tunnel should be configured as:

```text
DNS Only
```

Do **not** enable the orange-cloud proxy for the authoritative DNS endpoint used by the tunnel.

DNS propagation can take time depending on the provider and resolver cache.

---

# 🚀 Installation

One Line Installation

```bash
bash <(curl -s https://raw.githubusercontent.com/hosseinit1988/easy-dnstt-tunnel/main/DNSTT-Tunnel.sh)
```

Clone the repository:

```bash
git clone https://github.com/hosseinit1988/easy-dnstt-tunnel.git
cd easy-dnstt-tunnel
```

Make the installer executable:

```bash
chmod +x DNSTT-Tunnel.sh
```

Run it as root:

```bash
sudo ./DNSTT-Tunnel.sh
```

Or:

```bash
sudo bash DNSTT-Tunnel.sh
```

If you are already logged in as root:

```bash
bash DNSTT-Tunnel.sh
```

---

# 🧭 Installation Flow

The current script follows this general workflow:

```text
┌────────────────────────────────────┐
│        Easy DNSTT Tunnel            │
└──────────────────┬─────────────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ Collect configuration│
        │ Domain / Subdomain   │
        │ Server IP / Email    │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ DNS configuration    │
        │ Interactive guide    │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ System prerequisites │
        │ apt / packages       │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ UFW Firewall         │
        │ Required ports       │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ DNSTT Server         │
        │ Download + keys      │
        │ systemd service      │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ 3x-ui Installation   │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ SSL / Certbot        │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ Completion Summary   │
        └─────────────────────┘
```

---

# 📦 Packages Installed

The script installs the following packages through APT:

```text
curl
wget
git
ufw
jq
uuid-runtime
openssl
net-tools
```

It also installs Certbot and the Nginx Certbot integration during the SSL stage.

---

# 🔥 Firewall Ports

The script configures UFW for these ports:

| Port | Protocol | Purpose |
|---:|:---:|---|
| `22` | TCP | SSH |
| `53` | UDP | DNSTT DNS transport |
| `80` | TCP | HTTP / certificate validation |
| `443` | TCP | HTTPS / secure connections |
| `2053` | TCP | 3x-ui panel |

Check the firewall manually:

```bash
ufw status
```

---

# 🔐 DNSTT Keys

During installation, the script generates a DNSTT key pair:

```bash
cd /opt/dnstt
```

The generated key information is stored in:

```text
/opt/dnstt/dnstt-keys.txt
```

The public key is also displayed in the installation summary.

### ⚠️ Protect the private key

The private key is sensitive. Do not publish it in:

- GitHub repositories
- screenshots
- public Telegram channels
- bug reports
- logs
- public configuration files

If the private key is exposed, generate a new key pair and replace the server configuration.

---

# ⚙️ DNSTT systemd Service

The installer creates:

```text
/etc/systemd/system/dnstt.service
```

Useful commands:

### Check status

```bash
systemctl status dnstt
```

### Start

```bash
systemctl start dnstt
```

### Stop

```bash
systemctl stop dnstt
```

### Restart

```bash
systemctl restart dnstt
```

### Enable at boot

```bash
systemctl enable dnstt
```

### View logs

```bash
journalctl -u dnstt -f
```

### View recent logs

```bash
journalctl -u dnstt --no-pager -n 100
```

---

# 🔒 SSL Certificate

The script installs Certbot and attempts to obtain a certificate for:

```text
yourdomain.com
```

and:

```text
dns.yourdomain.com
```

The expected certificate location is:

```text
/etc/letsencrypt/live/YOUR_DOMAIN/
```

Typical files include:

```text
fullchain.pem
privkey.pem
```

If certificate issuance fails, check:

```text
• DNS resolution
• Port 80 accessibility
• Port 443 accessibility
• Domain ownership
• Existing services using port 80
• Firewall rules
```

---

# 🎛️ 3x-ui Panel

The installer invokes the 3x-ui installation script and attempts to retrieve the generated panel credentials.

The default panel port used by this project is:

```text
2053
```

After installation, check the displayed credentials and panel URL.

> **Security recommendation:** Change the panel username/password immediately after the first login and avoid exposing the management panel unnecessarily.

---

# 🧪 Verification

After installation, verify the DNSTT service:

```bash
systemctl is-active dnstt
```

Expected:

```text
active
```

Check listening ports:

```bash
ss -lntup | grep -E ':53|:2053|:80|:443'
```

Check DNS records:

```bash
dig A ns.example.com
```

and:

```bash
dig NS dns.example.com
```

You can also inspect the DNS delegation from an external machine.

---

# 🐛 Troubleshooting

## DNSTT service is not running

Run:

```bash
systemctl status dnstt
```

Then:

```bash
journalctl -u dnstt --no-pager -n 100
```

Look for:

```text
address already in use
permission denied
invalid key
invalid domain
DNS configuration errors
```

---

## Port 53 is already in use

Check:

```bash
ss -lntup | grep ':53'
```

A local DNS resolver such as `systemd-resolved`, `dnsmasq`, or another DNS service may already be listening on port 53.

Identify the process before changing anything:

```bash
lsof -i :53
```

Do not disable an existing resolver blindly on a production server.

---

## SSL certificate fails

Check whether port 80 is reachable:

```bash
ss -lntup | grep ':80'
```

Check DNS:

```bash
dig A example.com
```

Make sure the domain resolves to the correct public server IP.

---

## 3x-ui installation problems

Check the panel service and installed files:

```bash
systemctl status x-ui
```

and:

```bash
journalctl -u x-ui --no-pager -n 100
```

The 3x-ui installer is maintained externally, so installation behavior can change independently from this repository.

---

# 📁 Project Structure

Current repository structure is intentionally simple:

```text
easy-dnstt-tunnel/
│
├── DNSTT-Tunnel.sh
└── README.md
```

The main installer contains the complete deployment workflow.

---

# ⚠️ Important Project Notes

This README documents the **current implementation** of `DNSTT-Tunnel.sh`.

The current script advertises an enhanced 9-step workflow in its UI, but the checked-in implementation currently executes the primary installation stages through the SSL stage before displaying the completion summary.

In addition, some paths and variables shown in the completion summary are placeholders for functionality that may be expanded in future revisions, including:

```text
/opt/dnstt/client-config.txt
/opt/dnstt/manage.sh
INBOUND_ID
```

Therefore, users should treat the completion output as informational and verify the actual generated configuration and services on their server.

---

# 🔐 Security Considerations

This project performs privileged system administration tasks.

Before running it on a production server:

- Review the script.
- Use a clean VPS when possible.
- Keep the operating system updated.
- Protect the DNSTT private key.
- Change default/generated panel credentials.
- Restrict management ports where practical.
- Do not publish private configuration data.
- Review firewall rules after installation.
- Monitor systemd logs.
- Only use tunneling technology where you have authorization to do so.

Running a shell script as `root` means the script has full control over the operating system. Always inspect third-party installers before executing them.

---

# 🧰 Useful Commands

### Check server IP

```bash
curl -4 ifconfig.me
```

### Check DNS

```bash
dig A example.com
dig NS dns.example.com
```

### Check listening services

```bash
ss -lntup
```

### Check firewall

```bash
ufw status verbose
```

### Check DNSTT

```bash
systemctl status dnstt
```

### Follow DNSTT logs

```bash
journalctl -u dnstt -f
```

### Restart DNSTT

```bash
systemctl restart dnstt
```

---

# 🧑‍💻 Development

Contributions, bug reports, and improvements are welcome.

Suggested workflow:

```bash
git clone https://github.com/hosseinit1988/easy-dnstt-tunnel.git
cd easy-dnstt-tunnel

chmod +x DNSTT-Tunnel.sh
```

Test changes on a disposable VPS before deploying them to a production environment.

---

# 🤝 Contributing

If you find a bug or have an improvement:

1. Fork the repository.
2. Create a feature branch.
3. Test your changes.
4. Commit your changes.
5. Open a Pull Request.

For bugs, include:

```text
Operating system
Architecture
Relevant command output
DNSTT service status
Relevant journalctl output
Steps to reproduce
```

Never include private keys, passwords, tokens, or sensitive server information in an issue.

---

# 📜 License

Please check the repository for the applicable license before redistributing or modifying this project.

The project integrates external components, each of which may have its own license and terms.

---

# 🙏 Credits

This project builds on the work of the open-source networking community.

Special thanks to:

- **DNSTT** and its upstream contributors
- **3x-ui** and its maintainers
- The Linux and open-source communities

For technical details about DNSTT itself, see the upstream project documentation and source code.

---

# ⭐ Support the Project

If this project helped you:

- ⭐ Star the repository
- 🐛 Report bugs
- 💡 Suggest improvements
- 🔧 Submit pull requests
- 📢 Share the project with other developers

Your feedback helps improve the project.

---

<p align="center">
  <strong>Easy DNSTT Tunnel</strong><br>
  <sub>Automate the boring parts. Keep your deployment consistent.</sub>
</p>

<p align="center">
  Made with ❤️ by <a href="https://github.com/hosseinit1988">Hossein Shourgashti</a>
</p>
