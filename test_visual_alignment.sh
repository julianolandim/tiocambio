#!/bin/bash

# Teste visual de alinhamento

# Cores
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

# Função para desenhar linha centralizada
draw_line() {
    local text="$1"
    local width=${2:-80}

    # Remove códigos ANSI para calcular tamanho real
    local clean="$text"
    while [[ "$clean" =~ $'\033'\[[0-9\;]*m ]]; do
        clean="${clean//${BASH_REMATCH[0]}/}"
    done

    local text_length=${#clean}
    local padding=$(( (width - text_length - 2) / 2 ))
    local right_padding=$(( width - text_length - padding - 2 ))

    echo -ne "${CYAN}║${RESET}"
    printf '%*s' "$padding" ""
    echo -ne "$text"
    printf '%*s' "$right_padding" ""
    echo -e "${CYAN}║${RESET}"
}

# Função para desenhar borda superior
draw_top_border() {
    local width=${1:-80}
    echo -ne "${CYAN}╔"
    for ((i=0; i<width-2; i++)); do echo -n "═"; done
    echo -e "╗${RESET}"
}

# Função para desenhar borda inferior
draw_bottom_border() {
    local width=${1:-80}
    echo -ne "${CYAN}╚"
    for ((i=0; i<width-2; i++)); do echo -n "═"; done
    echo -e "╝${RESET}"
}

clear
echo "=== TESTE DE ALINHAMENTO VISUAL ==="
echo ""

draw_top_border 80
draw_line "Texto simples" 80
draw_line "${BOLD}${YELLOW}Texto com cores${RESET}" 80
draw_line "${BOLD}${YELLOW}💰  TIO CÂMBIO - CONVERSOR DE MOEDAS  💰${RESET}" 80
draw_line "${GREEN}▶ ${WHITE}${BOLD}1. Ver Cotações${RESET}" 80
draw_line "${CYAN}2. Converter Moedas${RESET}" 80
draw_bottom_border 80

echo ""
echo "As bordas estão alinhadas? (y/n)"
