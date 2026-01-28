#!/bin/bash

# =========================================================================
# AUTO RUNNER / WRAPPER FOR THEME INSTALLER
# By Sano Official
# =========================================================================

BOLD='\033[1m'; BLUE='\033[0;34m'; RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; NC='\033[0m'

run_remote_script() {
    bash <(curl -s https://raw.githubusercontent.com/Bangsano/themeinstaller/main/install.sh)
}

usage() {
    echo -e "${BOLD}PENGGUNAAN:${NC} bash $0 <OPSI_UTAMA> [ARGUMEN_TAMBAHAN...]"
    echo ""
    echo -e "${BOLD}DAFTAR OPSI UTAMA (Sesuai Menu install.sh):${NC}"
    echo -e "  ${GREEN}1${NC} <NOMOR_TEMA> [...] : Install Tema (1-12)"
    echo -e "  ${GREEN}2${NC}                     : Install Blueprint Framework"
    echo -e "  ${GREEN}3${NC}                     : Install Auto Suspend"
    echo -e "  ${GREEN}4${NC}                     : Reset Panel (Uninstall Theme)"
    echo -e "  ${GREEN}5${NC}                     : Uninstall Panel (Full Delete)"
    echo -e "  ${GREEN}6${NC} <TOKEN>             : Start Wings (Butuh Token)"
    echo -e "  ${GREEN}8${NC} <USER> <PASS>       : Hack Back Panel (Buat Admin)"
    echo -e "  ${GREEN}9${NC} <PASS>              : Ubah Password VPS"
    echo ""
    echo -e "${BOLD}CONTOH:${NC}"
    echo -e "  bash $0 1 1                     ${BLUE}# Install Tema Stellar${NC}"
    echo -e "  bash $0 1 3 'wa.me' 'ch' 'gc'   ${BLUE}# Install Enigma (Wajib 3 Link)${NC}"
    echo -e "  bash $0 1 10                    ${BLUE}# Install Nebula (Auto Install Blueprint)${NC}"
    echo -e "  bash $0 4                       ${BLUE}# Reset Panel${NC}"
    echo -e "  bash $0 8 'admin' 'Password123' ${BLUE}# Buat Akun Admin${NC}"
    exit 1
}

if [ -z "$1" ]; then
    run_remote_script
    exit 0
fi

MAIN_CHOICE="$1"

if [ "$MAIN_CHOICE" -eq 1 ]; then
    THEME_ID="$2"
    
    if [ -z "$THEME_ID" ]; then
        echo -e "${RED}${BOLD}Error: Harap masukkan nomor tema (1-12).${NC}"; usage
    fi

    echo -e "${BLUE}${BOLD}[AUTO] Memproses instalasi Tema Nomor #$THEME_ID...${NC}"

    if [ "$THEME_ID" -eq 3 ]; then
        if [ "$#" -ne 5 ]; then
            echo -e "${RED}${BOLD}Error: Tema Enigma (#3) butuh 3 link (WA, Channel, Group).${NC}"
            echo -e "Format: bash $0 1 3 <link_wa> <link_ch> <link_gc>"
            exit 1
        fi
        LINK_WA="$3"
        LINK_CH="$4"
        LINK_GC="$5"

        run_remote_script << EOF
$MAIN_CHOICE
$THEME_ID
y
$LINK_WA
$LINK_CH
$LINK_GC
x
EOF

    elif [ "$THEME_ID" -eq 10 ]; then
        run_remote_script << EOF
2
y
$MAIN_CHOICE
$THEME_ID
y


x
EOF

    elif [ "$THEME_ID" -ge 11 ] && [ "$THEME_ID" -le 12 ]; then
        run_remote_script << EOF
2
y
$MAIN_CHOICE
$THEME_ID
y
x
EOF

    else
        run_remote_script << EOF
$MAIN_CHOICE
$THEME_ID
y
x
EOF
    fi

elif [ "$MAIN_CHOICE" -eq 2 ]; then
    echo -e "${BLUE}${BOLD}[AUTO] Memproses instalasi Blueprint...${NC}"
    run_remote_script << EOF
$MAIN_CHOICE
y
x
EOF

elif [ "$MAIN_CHOICE" -eq 3 ]; then
    echo -e "${BLUE}${BOLD}[AUTO] Memproses instalasi Auto Suspend...${NC}"
    run_remote_script << EOF
$MAIN_CHOICE
y
x
EOF

elif [ "$MAIN_CHOICE" -eq 4 ]; then
    echo -e "${BLUE}${BOLD}[AUTO] Memproses Reset Panel...${NC}"
    run_remote_script << EOF
$MAIN_CHOICE
y
x
EOF

elif [ "$MAIN_CHOICE" -eq 5 ]; then
    echo -e "${RED}${BOLD}[AUTO] Memproses Uninstall Panel...${NC}"
    run_remote_script << EOF
$MAIN_CHOICE
y
x
EOF

elif [ "$MAIN_CHOICE" -eq 6 ]; then
    if [ -z "$2" ]; then
        echo -e "${RED}${BOLD}Error: Butuh token wings.${NC}"; usage
    fi
    echo -e "${BLUE}${BOLD}[AUTO] Mengonfigurasi Wings...${NC}"
    run_remote_script << EOF
$MAIN_CHOICE
$2
x
EOF

elif [ "$MAIN_CHOICE" -eq 7 ]; then
    echo -e "${YELLOW}${BOLD}Fitur Create Node sebaiknya dijalankan manual atau via script khusus.${NC}"
    run_remote_script

elif [ "$MAIN_CHOICE" -eq 8 ]; then
    if [ "$#" -ne 3 ]; then
        echo -e "${RED}${BOLD}Error: Butuh username dan password baru.${NC}"
        echo -e "Format: bash $0 8 <username> <password>"
        exit 1
    fi
    echo -e "${BLUE}${BOLD}[AUTO] Membuat User Admin Baru...${NC}"
    run_remote_script << EOF
$MAIN_CHOICE
$2
$3
x
EOF

elif [ "$MAIN_CHOICE" -eq 9 ]; then
    if [ -z "$2" ]; then
        echo -e "${RED}${BOLD}Error: Butuh password baru.${NC}"
        echo -e "Format: bash $0 9 <password_baru>"
        exit 1
    fi
    echo -e "${BLUE}${BOLD}[AUTO] Mengubah Password VPS...${NC}"
    run_remote_script << EOF
$MAIN_CHOICE
$2
$2
x
EOF

else
    echo -e "${RED}${BOLD}Error: Opsi utama '$MAIN_CHOICE' tidak ditemukan.${NC}"
    usage
fi

echo -e "\n${GREEN}${BOLD}[DONE] Proses telah selesai.${NC}"
