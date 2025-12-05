#!/bin/bash

# Teste simples das funções principais

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

    # Remove códigos ANSI manualmente para calcular comprimento real
    local clean="$text"
    # Remove sequências \033[...m e \x1b[...m
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

# Função para testar teclas
test_keys() {
    echo "Teste de teclas - Pressione setas ↑↓ ou 'q' para sair"
    echo ""

    while true; do
        local key=""
        local KEY_PRESSED=""

        # Ler primeiro caractere sem timeout
        IFS= read -rsn1 key

        # Detectar ESC ou setas
        if [[ "$key" == $'\x1b' ]]; then
            # Ler até 2 caracteres adicionais com timeout
            local seq=""
            IFS= read -rsn2 -t 0.5 seq 2>/dev/null

            case "$seq" in
                '[A'|'OA') KEY_PRESSED="up" ;;
                '[B'|'OB') KEY_PRESSED="down" ;;
                '[C'|'OC') KEY_PRESSED="right" ;;
                '[D'|'OD') KEY_PRESSED="left" ;;
                '') KEY_PRESSED="esc" ;;
                *) KEY_PRESSED="esc" ;;
            esac
        elif [[ "$key" == "" ]]; then
            KEY_PRESSED="enter"
        elif [[ "$key" == " " ]]; then
            KEY_PRESSED="space"
        elif [[ "$key" == "q" || "$key" == "Q" ]]; then
            KEY_PRESSED="quit"
        else
            KEY_PRESSED="$key"
        fi

        echo "Tecla detectada: $KEY_PRESSED"

        if [[ "$KEY_PRESSED" == "quit" ]]; then
            echo "Saindo..."
            break
        fi
    done
}

clear
echo "=== TESTE DE ALINHAMENTO ==="
draw_line "Texto simples" 80
draw_line "${BOLD}${YELLOW}Texto com cores${RESET}" 80
draw_line "${GREEN}▶ ${WHITE}${BOLD}1. Ver Cotações${RESET}" 80
echo ""
echo "Alinhamento OK? (s/n)"
read resp

if [[ "$resp" == "s" ]]; then
    echo ""
    test_keys
fi
