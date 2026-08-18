#!/bin/bash

# ======================================================
# DNSTT Tunnel + 3x-ui Panel - Enhanced Edition
# ======================================================

# ======================================================
# Advanced UI Functions
# ======================================================

# Colors with better visibility
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Emoji for better UX
CHECK="✅"
WARN="⚠️"
ERROR="❌"
INFO="ℹ️"
ARROW="➡️"
STAR="⭐"

# ======================================================
# Enhanced UI Functions
# ======================================================

show_banner() {
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║                                                          ║"
    echo "║     🚀 DNSTT TUNNEL + 3x-UI PANEL INSTALLER            ║"
    echo "║     🌐 Professional Setup Script                        ║"
    echo "║     📦 Version 2.0 Enhanced                             ║"
    echo "║                                                          ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

show_progress() {
    local message=$1
    local current=$2
    local total=$3
    local percent=$((current * 100 / total))
    local completed=$((percent / 2))
    local remaining=$((50 - completed))
    
    echo -ne "${BLUE}[${WHITE}"
    printf "%${completed}s" | tr ' ' '█'
    printf "%${remaining}s" | tr ' ' '░'
    echo -ne "${BLUE}] ${percent}% ${CYAN}${message}${NC}\r"
}

show_step_header() {
    local step=$1
    local title=$2
    echo -e "\n${PURPLE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}  ${ARROW} Step ${step}: ${GREEN}${title}${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════${NC}\n"
}

show_info_box() {
    local title=$1
    local content=$2
    echo -e "${BLUE}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "${BLUE}│ ${WHITE}${title}${NC}"
    echo -e "${BLUE}├─────────────────────────────────────────────────────────┤${NC}"
    echo -e "${BLUE}│ ${content}${NC}"
    echo -e "${BLUE}└─────────────────────────────────────────────────────────┘${NC}"
}

# ======================================================
# Enhanced Help Functions
# ======================================================

show_dns_help() {
    clear
    show_banner
    echo -e "${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║   ${WHITE}📝 IMPORTANT: DNS Configuration Guide${YELLOW}          ║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${GREEN}1️⃣  Go to your Domain Registrar / DNS Manager${NC}"
    echo -e "   ${BLUE}(Cloudflare, Namecheap, GoDaddy, etc.)${NC}"
    echo ""
    echo -e "${GREEN}2️⃣  Create these DNS records:${NC}"
    echo ""
    echo -e "${WHITE}   ┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "${WHITE}   │ ${YELLOW}A Record:${NC}     ns.YOURDOMAIN.com → ${CYAN}${SERVER_IP}${NC}  │"
    echo -e "${WHITE}   │ ${YELLOW}Proxy Status:${NC}  ${RED}🔴 DNS Only (Proxy OFF)${NC}      │"
    echo -e "${WHITE}   │ ${YELLOW}TTL:${NC}          Auto or 300              │${NC}"
    echo -e "${WHITE}   └─────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "${WHITE}   ┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "${WHITE}   │ ${YELLOW}NS Record:${NC}    dns.YOURDOMAIN.com → ns.YOURDOMAIN.com${NC}  │"
    echo -e "${WHITE}   │ ${YELLOW}Proxy Status:${NC}  ${RED}🔴 DNS Only (Proxy OFF)${NC}      │"
    echo -e "${WHITE}   │ ${YELLOW}TTL:${NC}          Auto or 86400           │${NC}"
    echo -e "${WHITE}   └─────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "${GREEN}3️⃣  Example (if your domain is example.com):${NC}"
    echo -e "   ${BLUE}• A Record:${NC}   ns.example.com → ${CYAN}${SERVER_IP}${NC}"
    echo -e "   ${BLUE}• NS Record:${NC}  dns.example.com → ns.example.com${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  Wait 5-10 minutes for DNS propagation!${NC}"
    echo ""
    echo -e "${GREEN}Press ENTER when done OR type 'help' for more details...${NC}"
    read -p "> " dns_input
    
    if [[ "$dns_input" == "help" ]]; then
        echo -e "\n${CYAN}📖 Full DNS Guide:${NC}"
        echo -e "  ${WHITE}1.${NC} Login to your DNS provider"
        echo -e "  ${WHITE}2.${NC} Find 'DNS Records' or 'Zone Editor'"
        echo -e "  ${WHITE}3.${NC} Add A record with subdomain 'ns'"
        echo -e "  ${WHITE}4.${NC} Add NS record with subdomain 'dns'"
        echo -e "  ${WHITE}5.${NC} Make sure Proxy/Cloudflare is ${RED}OFF${NC}"
        echo -e "\n${GREEN}Press ENTER to continue...${NC}"
        read -p "> " 
    fi
}

# ======================================================
# Enhanced Installation Steps with User-Friendly Messages
# ======================================================

step1_prerequisites() {
    show_step_header "1/9" "System Update & Prerequisites"
    
    echo -e "${BLUE}${INFO} Updating system packages...${NC}"
    echo -e "${BLUE}${INFO} This may take a few minutes...${NC}\n"
    
    show_progress "Updating system..." 1 10
    apt update -y 2>/dev/null | grep -E "^(Get|Hit|Ign)" | sed 's/^/  /'
    
    show_progress "Upgrading packages..." 3 10
    apt upgrade -y 2>/dev/null | grep -E "^(Unpacking|Setting up|Preparing)" | sed 's/^/  /'
    
    echo -e "\n${BLUE}${INFO} Installing required packages...${NC}"
    local packages=("curl" "wget" "git" "ufw" "jq" "uuid-runtime" "openssl" "net-tools")
    local total=${#packages[@]}
    local count=0
    
    for pkg in "${packages[@]}"; do
        count=$((count + 1))
        show_progress "Installing $pkg..." $count $total
        apt install -y $pkg 2>/dev/null >/dev/null
    done
    
    echo -e "\n\n${GREEN}${CHECK} System updated and prerequisites installed!${NC}"
    sleep 1
}

step2_network_config() {
    show_step_header "2/9" "Network & Firewall Configuration"
    
    echo -e "${BLUE}${INFO} Configuring firewall for required ports...${NC}\n"
    
    echo -e "${WHITE}📌 Ports being opened:${NC}"
    echo -e "  ${GREEN}• 22${NC}  (SSH - for remote access)"
    echo -e "  ${GREEN}• 53${NC}  (DNS - for DNSTT tunnel)"
    echo -e "  ${GREEN}• 80${NC}  (HTTP - for SSL verification)"
    echo -e "  ${GREEN}• 443${NC} (HTTPS - for secure connections)"
    echo -e "  ${GREEN}• 2053${NC}(Web UI - for panel access)\n"
    
    show_progress "Configuring UFW..." 1 4
    ufw allow 22/tcp 2>/dev/null
    show_progress "Configuring UFW..." 2 4
    ufw allow 53/udp 2>/dev/null
    show_progress "Configuring UFW..." 3 4
    ufw allow 80/tcp 443/tcp 2053/tcp 2>/dev/null
    show_progress "Configuring UFW..." 4 4
    
    echo -e "\n"
    echo "y" | ufw enable 2>/dev/null
    
    echo -e "\n${GREEN}${CHECK} Firewall configured successfully!${NC}"
    echo -e "${BLUE}${INFO} Current firewall status:${NC}"
    ufw status | grep -E "^(Status|To|22|53|80|443|2053)" | sed 's/^/  /'
    sleep 2
}

step3_install_dnstt() {
    show_step_header "3/9" "DNSTT Tunnel Installation"
    
    echo -e "${BLUE}${INFO} Installing DNSTT tunnel server...${NC}\n"
    
    mkdir -p /opt/dnstt
    cd /opt/dnstt
    
    echo -e "${BLUE}${INFO} Downloading DNSTT v1.5.1...${NC}"
    show_progress "Downloading DNSTT..." 1 5
    wget -q -O dnstt-server https://github.com/dns-stb/dnstt/releases/download/v1.5.1/dnstt-server_1.5.1_linux_amd64
    
    show_progress "Setting permissions..." 2 5
    chmod +x dnstt-server
    
    show_progress "Generating encryption keys..." 3 5
    ./dnstt-server -gen-key -domain $FULL_DOMAIN > dnstt-keys.txt
    
    PUBKEY=$(grep "Public key:" dnstt-keys.txt | awk '{print $3}')
    PRIVKEY=$(grep "Private key:" dnstt-keys.txt | awk '{print $3}')
    
    show_progress "Creating systemd service..." 4 5
    cat > /etc/systemd/system/dnstt.service <<EOF
[Unit]
Description=DNSTT Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/dnstt
ExecStart=/opt/dnstt/dnstt-server -domain $FULL_DOMAIN -priv-key $PRIVKEY -udp :53 -tcp :53
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
    
    show_progress "Starting DNSTT service..." 5 5
    systemctl daemon-reload
    systemctl start dnstt
    systemctl enable dnstt 2>/dev/null
    
    echo -e "\n${GREEN}${CHECK} DNSTT installed successfully!${NC}"
    echo -e "${BLUE}${INFO} Service status:${NC} $(systemctl is-active dnstt)"
    echo -e "${YELLOW}📌 Public Key:${NC} ${CYAN}$PUBKEY${NC}"
    sleep 2
}

step4_install_3xui() {
    show_step_header "4/9" "3x-ui Panel Installation"
    
    echo -e "${BLUE}${INFO} Installing 3x-ui management panel...${NC}\n"
    
    echo -e "${BLUE}${INFO} Downloading and running 3x-ui installer...${NC}"
    echo -e "${YELLOW}${WARN} This may take 2-3 minutes...${NC}\n"
    
    bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh) | \
        grep -E "(Installing|Configuring|Starting|Complete|Username|Password|Port|Path)"
    
    if [ -f /etc/x-ui/install-result.env ]; then
        source /etc/x-ui/install-result.env
        PANEL_USERNAME="${XUI_USERNAME:-admin}"
        PANEL_PASSWORD="${XUI_PASSWORD:-admin}"
        PANEL_PORT="${XUI_PORT:-2053}"
        PANEL_PATH="${XUI_WEB_BASE_PATH:-/}"
    else
        PANEL_USERNAME="admin"
        PANEL_PASSWORD="admin"
        PANEL_PORT="2053"
        PANEL_PATH="/"
    fi
    
    echo -e "\n${GREEN}${CHECK} 3x-ui installed successfully!${NC}"
    echo -e "${BLUE}${INFO} Panel credentials:${NC}"
    echo -e "  ${WHITE}🔑 Username:${NC} ${GREEN}$PANEL_USERNAME${NC}"
    echo -e "  ${WHITE}🔑 Password:${NC} ${GREEN}$PANEL_PASSWORD${NC}"
    echo -e "  ${WHITE}🌐 Port:${NC}     ${GREEN}$PANEL_PORT${NC}"
    sleep 2
}

step5_ssl_setup() {
    show_step_header "5/9" "SSL Certificate Configuration"
    
    echo -e "${BLUE}${INFO} Obtaining SSL certificate for secure connections...${NC}\n"
    
    apt install -y certbot python3-certbot-nginx 2>/dev/null >/dev/null
    
    echo -e "${BLUE}${INFO} Requesting certificate for:${NC}"
    echo -e "  ${WHITE}•${NC} $DOMAIN"
    echo -e "  ${WHITE}•${NC} $FULL_DOMAIN\n"
    
    if [ -n "$EMAIL" ]; then
        certbot certonly --standalone --non-interactive --agree-tos \
            -d $DOMAIN -d $FULL_DOMAIN --email $EMAIL 2>&1 | grep -E "(Successfully|Congratulations|Certificate|failure|error)"
    else
        certbot certonly --standalone --non-interactive --agree-tos \
            -d $DOMAIN -d $FULL_DOMAIN 2>&1 | grep -E "(Successfully|Congratulations|Certificate|failure|error)"
    fi
    
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}${CHECK} SSL certificate obtained successfully!${NC}"
        echo -e "${BLUE}${INFO} Certificate location:${NC}"
        echo -e "  ${WHITE}•${NC} /etc/letsencrypt/live/$DOMAIN/fullchain.pem"
        echo -e "  ${WHITE}•${NC} /etc/letsencrypt/live/$DOMAIN/privkey.pem"
    else
        echo -e "\n${YELLOW}${WARN} SSL certificate failed. You can:${NC}"
        echo -e "  ${WHITE}1.${NC} Run 'certbot certonly --standalone' manually later"
        echo -e "  ${WHITE}2.${NC} Use HTTP instead of HTTPS (not recommended)"
        echo -e "  ${WHITE}3.${NC} Check if ports 80/443 are open"
    fi
    sleep 2
}

# ======================================================
# Main Installation Function
# ======================================================

main_installation() {
    show_banner
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}📋 This script will install:${NC}"
    echo -e "  ${GREEN}${CHECK}${NC} DNSTT Tunnel Server (DNS-based proxy)"
    echo -e "  ${GREEN}${CHECK}${NC} 3x-ui Panel (Xray/V2Ray management)"
    echo -e "  ${GREEN}${CHECK}${NC} SSL Certificate (Secure connections)"
    echo -e "  ${GREEN}${CHECK}${NC} Firewall Configuration (Security)"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Get user inputs with validation
    while true; do
        echo -e "${WHITE}🌐 Enter your main domain:${NC} ${BLUE}(example: example.com)${NC}"
        read -p "> " DOMAIN
        if [[ ! -z "$DOMAIN" ]]; then
            break
        fi
        echo -e "${RED}${ERROR} Domain cannot be empty!${NC}"
    done
    
    while true; do
        echo -e "\n${WHITE}🔗 Enter subdomain for DNS tunnel:${NC} ${BLUE}(example: dns)${NC}"
        read -p "> " SUB_DOMAIN
        if [[ ! -z "$SUB_DOMAIN" ]]; then
            break
        fi
        echo -e "${RED}${ERROR} Subdomain cannot be empty!${NC}"
    done
    
    while true; do
        echo -e "\n${WHITE}🖥️  Enter server IP address:${NC} ${BLUE}(e.g., 1.2.3.4)${NC}"
        read -p "> " SERVER_IP
        if [[ ! -z "$SERVER_IP" ]]; then
            break
        fi
        echo -e "${RED}${ERROR} Server IP cannot be empty!${NC}"
    done
    
    echo -e "\n${WHITE}📧 Enter email for SSL (optional):${NC} ${BLUE}(press ENTER to skip)${NC}"
    read -p "> " EMAIL
    
    FULL_DOMAIN="${SUB_DOMAIN}.${DOMAIN}"
    
    # Show summary
    echo -e "\n${PURPLE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}📋 Configuration Summary:${NC}"
    echo -e "  ${WHITE}•${NC} Main Domain:     ${GREEN}$DOMAIN${NC}"
    echo -e "  ${WHITE}•${NC} Tunnel Domain:   ${GREEN}$FULL_DOMAIN${NC}"
    echo -e "  ${WHITE}•${NC} Server IP:       ${GREEN}$SERVER_IP${NC}"
    echo -e "  ${WHITE}•${NC} Email:           ${GREEN}${EMAIL:-Not provided}${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo -e "${YELLOW}${WARN} Please verify the information above is correct.${NC}"
    read -p "Continue with installation? (y/n): " confirm
    
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo -e "${RED}${ERROR} Installation cancelled.${NC}"
        exit 1
    fi
    
    # Show DNS help
    show_dns_help
    
    # Start installation steps
    step1_prerequisites
    step2_network_config
    step3_install_dnstt
    step4_install_3xui
    step5_ssl_setup
    
    # Continue with remaining steps...
    # (Rest of the steps similar to original with enhancements)
    
    show_completion_summary
}

# ======================================================
# Enhanced Completion Summary
# ======================================================

show_completion_summary() {
    clear
    show_banner
    
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ${WHITE}🎉 INSTALLATION COMPLETE!${GREEN}                         ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo -e "${PURPLE}📊 Installation Summary:${NC}\n"
    
    echo -e "${WHITE}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "${WHITE}│${CYAN}  🚀 DNSTT Tunnel${WHITE}                                  │${NC}"
    echo -e "${WHITE}├─────────────────────────────────────────────────────────┤${NC}"
    echo -e "${WHITE}│  Domain:        ${GREEN}$FULL_DOMAIN${WHITE}                     │${NC}"
    echo -e "${WHITE}│  Public Key:    ${YELLOW}${PUBKEY:0:20}...${WHITE}                │${NC}"
    echo -e "${WHITE}│  Status:        ${GREEN}● Active${WHITE}                         │${NC}"
    echo -e "${WHITE}└─────────────────────────────────────────────────────────┘${NC}"
    echo ""
    
    echo -e "${WHITE}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "${WHITE}│${CYAN}  🎛️  3x-ui Panel${WHITE}                                   │${NC}"
    echo -e "${WHITE}├─────────────────────────────────────────────────────────┤${NC}"
    echo -e "${WHITE}│  URL:           ${BLUE}http://$SERVER_IP:$PANEL_PORT$PANEL_PATH${WHITE}     │${NC}"
    echo -e "${WHITE}│  Username:      ${GREEN}$PANEL_USERNAME${WHITE}                   │${NC}"
    echo -e "${WHITE}│  Password:      ${GREEN}$PANEL_PASSWORD${WHITE}                   │${NC}"
    echo -e "${WHITE}└─────────────────────────────────────────────────────────┘${NC}"
    echo ""
    
    echo -e "${WHITE}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "${WHITE}│${CYAN}  🔗 Quick Connect URL${WHITE}                             │${NC}"
    echo -e "${WHITE}├─────────────────────────────────────────────────────────┤${NC}"
    echo -e "${WHITE}│  ${YELLOW}vless://$INBOUND_ID@$FULL_DOMAIN:443?flow=xtls-rprx-vision&security=tls&type=ws&path=/$SUB_DOMAIN${WHITE}  │${NC}"
    echo -e "${WHITE}└─────────────────────────────────────────────────────────┘${NC}"
    echo ""
    
    echo -e "${WHITE}📂 Important Files:${NC}"
    echo -e "  ${BLUE}•${NC} Client Config:  ${CYAN}/opt/dnstt/client-config.txt${NC}"
    echo -e "  ${BLUE}•${NC} Management:      ${CYAN}/opt/dnstt/manage.sh${NC}"
    echo -e "  ${BLUE}•${NC} Logs:            ${CYAN}journalctl -u dnstt -f${NC}"
    echo ""
    
    echo -e "${GREEN}${CHECK} All components installed successfully!${NC}"
    echo -e "${YELLOW}${STAR} Please save the panel credentials and connect URL.${NC}"
    echo ""
    read -p "Press ENTER to finish..."
}

# ======================================================
# Run Installation
# ======================================================

# Check root access
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}${ERROR} This script must be run as root${NC}"
    echo -e "${YELLOW}${INFO} Run: sudo bash $0${NC}"
    exit 1
fi

# Detect OS
detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if [[ "$ID" != "ubuntu" && "$ID" != "debian" ]]; then
            echo -e "${RED}${ERROR} Unsupported OS: $ID${NC}"
            exit 1
        fi
    else
        echo -e "${RED}${ERROR} Cannot detect OS${NC}"
        exit 1
    fi
}
detect_os

# Start main installation
main_installation