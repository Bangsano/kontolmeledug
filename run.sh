#!/bin/bash

# =========================================================================
# Skrip Pemanggil Otomatis untuk Theme Installer
# by Sano Official
# =========================================================================

# --- Variabel & Fungsi Bantuan ---
BOLD='\033[1m'; BLUE='\033[0;34m'; RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'
run_remote_script() {
    bash <(curl -s https://raw.githubusercontent.com/Bangsano/themeinstaller/main/install.sh)
}
usage() {
    echo -e "${BOLD}Penggunaan:${NC} bash $0 <opsi_utama> [opsi_tema] [argumen_tambahan...]"
    echo ""
    echo -e "${BOLD}Opsi Utama:${NC}"
    echo "  ${GREEN}1${NC} : Install Tema"
    echo "  ${GREEN}2${NC} : Uninstall/Reset Tema"
    echo ""
    echo -e "${BOLD}Contoh:${NC}"
    echo "  bash $0 1 1         ${BLUE}# Install tema Stellar${NC}"
    echo "  bash $0 1 3 'wa' 'ch' 'gc'  ${BLUE}# Install tema Enigma dengan link${NC}"
    echo "  bash $0 1 9         ${BLUE}# Install tema Nebula (otomatis install dependensi)${NC}"
    echo "  bash $0 2           ${BLUE}# Jalankan reset total panel${NC}"
    exit 1
}

# =========================================================================
#                            LOGIKA UTAMA
# =========================================================================

# Jika tidak ada argumen, jalankan skrip utama secara interaktif
if [ -z "$1" ]; then
    run_remote_script
    exit 0
fi

MAIN_CHOICE="$1"
THEME_CHOICE="$2"

# --- ALUR INSTALASI TEMA ---
if [ "$MAIN_CHOICE" -eq 1 ]; then
    if [ -z "$THEME_CHOICE" ]; then
        echo -e "${RED}${BOLD}Error: Pilihan tema (argumen kedua) wajib diisi.${NC}"; usage
    fi
    
    echo -e "${BLUE}${BOLD}Memulai alur instalasi untuk tema #$THEME_CHOICE...${NC}"

    if [ "$THEME_CHOICE" -eq 3 ]; then # Tema Enigma
        if [ "$#" -ne 5 ]; then
            echo -e "${RED}${BOLD}Error: Tema Enigma (#3) butuh 3 argumen link.${NC}"; usage
        fi
        run_remote_script << EOF
1
$THEME_CHOICE
y
$3
$4
$5
x
EOF
    elif [ "$THEME_CHOICE" -eq 10 ]; then # Tema Nebula
        if [ "$#" -ne 2 ]; then
            echo -e "${RED}${BOLD}Error: Tema Nebula (#10) tidak butuh argumen tambahan.${NC}"; usage
        fi
        run_remote_script << EOF
8
y
1
$THEME_CHOICE
y


x
EOF
    elif [ "$THEME_CHOICE" -eq 11 ]; then # Tema Recolor
        if [ "$#" -ne 2 ]; then
            echo -e "${RED}${BOLD}Error: Tema Recolor (#11) tidak butuh argumen tambahan.${NC}"; usage
        fi
        run_remote_script << EOF
8
y
1
$THEME_CHOICE
y
x
EOF
    else # Semua tema manual lainnya
        if [ "$#" -ne 2 ]; then
            echo -e "${RED}${BOLD}Error: Tema ini tidak butuh argumen tambahan.${NC}"; usage
        fi
        run_remote_script << EOF
1
$THEME_CHOICE
y
x
EOF
    fi

# --- ALUR UNINSTALL TEMA ---
elif [ "$MAIN_CHOICE" -eq 2 ]; then
    if [ "$#" -ne 1 ]; then
        echo -e "${RED}${BOLD}Error: Opsi uninstall tidak butuh argumen tambahan.${NC}"; usage
    fi
    echo -e "${BLUE}${BOLD}Memulai alur uninstall (reset panel)...${NC}"
    run_remote_script << EOF
2
y
x
EOF

# --- OPSI TIDAK VALID ---
else
    echo -e "${RED}${BOLD}Error: Opsi utama '$MAIN_CHOICE' tidak valid.${NC}"; usage
fi

echo -e "\n${GREEN}${BOLD}Proses selesai.${NC}"
