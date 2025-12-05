#!/bin/bash

CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

remove_ansi() {
    local text="$1"
    local clean="$text"
    
    # Remove códigos ANSI
    while [[ "$clean" =~ $'\033'\[[0-9\;]*m ]]; do
        clean="${clean//${BASH_REMATCH[0]}/}"
    done
    
    echo "$clean"
}

# Testar com texto real do menu
text1="${BOLD}${WHITE}MENU PRINCIPAL${RESET}"
text2="${CYAN}2. Converter Moedas${RESET}"
text3="Ver Cotações"

echo "=== TESTE DE REMOÇÃO DE ANSI ==="
echo ""
echo "Texto 1 ORIGINAL:"
echo -e "$text1"
echo "Texto 1 LIMPO: '$(remove_ansi "$text1")'"
echo "Comprimento: ${#$(remove_ansi "$text1")}"
echo ""
echo "Texto 2 ORIGINAL:"
echo -e "$text2"
echo "Texto 2 LIMPO: '$(remove_ansi "$text2")'"
echo "Comprimento: $((${#$(remove_ansi "$text2")}))"
echo ""
echo "Texto 3: '$(remove_ansi "$text3")'"
echo "Comprimento: ${#text3}"
