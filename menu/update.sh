#!/bin/bash

#!/bin/bash
clear

# =============================================
#           [ Konfigurasi Warna ]
# =============================================
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export CYAN='\033[0;36m'
export NC='\033[0m'

# =============================================
#          [ Fungsi Pengecekan IP ]
check_ip_and_get_info() {
    local ip=$1
    while IFS= read -r line; do
        # Hapus karakter khusus dan spasi berlebih
        line=$(echo "$line" | tr -d '\r' | sed 's/[^[:print:]]//g' | xargs)
        
        # Split baris menjadi array
        read -ra fields <<< "$line"
        
        
        # Kolom 4 = IP Address (index 3)
        if [[ "${fields[3]}" == "$ip" ]]; then
            client_name="${fields[1]}"  # Kolom 2
            exp_date="${fields[2]}"     # Kolom 3
            
            # Bersihkan tanggal dari karakter khusus
            exp_date=$(echo "$exp_date" | sed 's/[^0-9-]//g' | xargs)
            
            return 0
        fi
    done <<< "$permission_file"
    return 1
}

# =============================================
#          [ Main Script ]
# =============================================

# Ambil data dari GitHub dengan timeout
permission_file=$(curl -s --connect-timeout 10 https://raw.githubusercontent.com/heruhendri/izin/refs/heads/main/amerikano)

# Validasi file permission
if [ -z "$permission_file" ]; then
    echo -e "${RED}❌ Gagal mengambil data lisensi!${NC}"
    exit 1
fi

# Ambil IP VPS dengan metode alternatif
IP_VPS=$(curl -s ipv4.icanhazip.com)

# =============================================
#          [ Pengecekan IP ]
# =============================================
echo -e "${GREEN}⌛ Memeriksa lisensi...${NC}"
if check_ip_and_get_info "$IP_VPS"; then
    
    # Validasi format tanggal ISO 8601
    if ! [[ "$exp_date" =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; then
        echo -e "${RED}❌ Format tanggal invalid: '$exp_date' (harus YYYY-MM-DD)${NC}"
        exit 1
    fi

    # Validasi tanggal menggunakan date
    if ! date -d "$exp_date" "+%s" &>/dev/null; then
        echo -e "${RED}❌ Tanggal tidak valid secara kalender: $exp_date${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ IP tidak terdaftar!${NC}"
    echo -e "➥ Hubungi admin ${CYAN}「 ✦ HOKAGE LEGEND ✦ 」${NC}"
    exit 1
fi

# =============================================
#          [ Hitung Hari Tersisa ]
# =============================================
current_epoch=$(date +%s)
exp_epoch=$(date -d "$exp_date" +%s)

if (( exp_epoch < current_epoch )); then
    echo -e "${RED}❌ Masa aktif telah habis!${NC}"
    exit 1
fi

days_remaining=$(( (exp_epoch - current_epoch) / 86400 ))

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
echo -e " ═════════════════════════════════════════════════"
echo -e " [INFO] Downloading File"
sleep 2
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/update "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/m-tcp "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/m-tcp.sh" && chmod +x /usr/bin/m-tcp

wget -q -O /usr/bin/m-theme "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/m-theme.sh" && chmod +x /usr/bin/m-theme
wget -q -O /usr/bin/m-vmess "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/m-vmess.sh" && chmod +x /usr/bin/m-vmess
wget -q -O /usr/bin/m-vless "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/m-vless.sh" && chmod +x /usr/bin/m-vless
wget -q -O /usr/bin/m-trojan "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/m-trojan.sh" && chmod +x /usr/bin/m-trojan

wget -q -O /usr/bin/system "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/system.sh" && chmod +x /usr/bin/system
wget -q -O /usr/bin/sshws "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/sshws.sh" && chmod +x /usr/bin/sshws
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/cekservice "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/cekservice.sh" && chmod +x /usr/bin/cekservice
wget -q -O /usr/bin/m-update "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/m-update.sh" && chmod +x /usr/bin/m-update
wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/tendang.sh" && chmod +x /usr/bin/tendang
wget -q -O /usr/bin/check-port "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/check-port.sh" && chmod +x /usr/bin/check-port

wget -q -O /usr/bin/menu-backup "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/menu-backup" && chmod +x /usr/bin/menu-backup
wget -q -O /usr/bin/auto-backup "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/auto-backup.sh" && chmod +x /usr/bin/auto-backup
wget -q -O /usr/bin/auto-restore "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/auto-restore.sh" && chmod +x /usr/bin/auto-restore
wget -q -O /usr/bin/manual-backup "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/manual-backup.sh" && chmod +x /usr/bin/manual-backup
wget -q -O /usr/bin/manual-restore "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/manual-restore.sh" && chmod +x /usr/bin/manual-restore

wget -q -O /usr/bin/xraylimit "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/xraylimit.sh" && chmod +x /usr/bin/xraylimit
wget -q -O /usr/bin/trialvmess "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/trialvmess.sh" && chmod +x /usr/bin/trialvmess
wget -q -O /usr/bin/trialvless "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/trialtrojan.sh" && chmod +x /usr/bin/trialtrojan
wget -q -O /usr/bin/trialtrojan "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/trialvless.sh" && chmod +x /usr/bin/trialvless
wget -q -O /usr/bin/trialssh "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/trialssh.sh" && chmod +x /usr/bin/trialssh
wget -q -O /usr/bin/trial "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/trial.sh" && chmod +x /usr/bin/trial
wget -q -O /usr/bin/online "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/online" && chmod +x /usr/bin/online
wget -q -O /usr/bin/trojan-online "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/trojan-online" && chmod +x /usr/bin/trojan-online
wget -q -O /usr/bin/ceklimit "https://raw.githubusercontent.com/heruhendri/genom/refs/heads/main/menu/ceklimit" && chmod +x /usr/bin/ceklimit
wget -q -O /usr/bin/atur-backup "https://github.com/heruhendri/genom/raw/refs/heads/main/menu/atur-backup" && chmod +x /usr/bin/atur-backup
wget -q -O /usr/bin/online-xray "https://github.com/heruhendri/genom/raw/refs/heads/main/menu/online-xray" && chmod +x /usr/bin/online-xray
wget -q -O /usr/bin/online-trojan "https://github.com/heruhendri/genom/raw/refs/heads/main/menu/online-trojan" && chmod +x /usr/bin/online-trojan

clear
echo -e ""
echo -e " ═════════════════════════════════════════════════"
echo -e " [INFO] Download File Successfully"
sleep 2
exit
