#!/bin/bash

# Script para testar alinhamento do TUI

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

# Função para remover códigos ANSI
strip_ansi() {
    local text="$1"
    echo "$text" | sed -E 's/\x1b\[[0-9;]*m//g'
}

# Função para calcular comprimento visual
visual_length() {
    local text="$1"
    local clean=$(strip_ansi "$text")
    echo "${#clean}"
}

# Função para desenhar linha
draw_line() {
    local text="$1"
    local width=${2:-80}
    local text_length=$(visual_length "$text")
    local padding=$(( (width - text_length - 2) / 2 ))
    local right_padding=$(( width - text_length - padding - 2 ))

    echo -ne "${CYAN}║${RESET}"
    printf '%*s' "$padding" ""
    echo -ne "$text"
    printf '%*s' "$right_padding" ""
    echo -e "${CYAN}║${RESET}"
}

# Teste
clear
echo "=== TESTE DE ALINHAMENTO ==="
echo ""

# Linha simples
draw_line "Texto simples" 80

# Linha com cores
draw_line "${BOLD}${YELLOW}Texto com cores${RESET}" 80

# Linha com emoji
draw_line "${BOLD}${YELLOW}💰 TIO CÂMBIO 💰${RESET}" 80

# Linha complexa
draw_line "${GREEN}▶ ${WHITE}${BOLD}1. Ver Cotações${RESET}" 80

echo ""
echo "=== FIM DO TESTE ==="
