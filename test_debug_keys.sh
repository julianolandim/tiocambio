#!/bin/bash

# Teste de detecção de setas - DEBUG MODE

KEY_PRESSED=""

read_key() {
    local key=""
    KEY_PRESSED=""

    # Ler primeiro caractere
    IFS= read -rsn1 key

    # Mostrar o que foi lido
    echo "DEBUG: Primeiro byte lido: $(printf '%q' "$key")"

    # Detectar ESC ou setas
    if [[ "$key" == $'\x1b' ]]; then
        echo "DEBUG: ESC detectado, lendo próximo byte..."
        # Ler próximo byte individualmente
        local seq1=""
        IFS= read -rsn1 -t 0.1 seq1 2>/dev/null

        echo "DEBUG: Segundo byte lido: $(printf '%q' "$seq1")"

        if [[ "$seq1" == "[" ]]; then
            echo "DEBUG: '[' detectado, lendo terceiro byte..."
            # Ler terceiro byte (A, B, C, D)
            local seq2=""
            IFS= read -rsn1 -t 0.1 seq2 2>/dev/null

            echo "DEBUG: Terceiro byte lido: $(printf '%q' "$seq2")"

            case "$seq2" in
                'A') KEY_PRESSED="up" ;;
                'B') KEY_PRESSED="down" ;;
                'C') KEY_PRESSED="right" ;;
                'D') KEY_PRESSED="left" ;;
                *) KEY_PRESSED="esc" ;;
            esac
        elif [[ "$seq1" == "O" ]]; then
            echo "DEBUG: 'O' detectado, lendo terceiro byte..."
            # Ler terceiro byte (A, B, C, D) - modo alternativo
            local seq2=""
            IFS= read -rsn1 -t 0.1 seq2 2>/dev/null

            echo "DEBUG: Terceiro byte lido: $(printf '%q' "$seq2")"

            case "$seq2" in
                'A') KEY_PRESSED="up" ;;
                'B') KEY_PRESSED="down" ;;
                'C') KEY_PRESSED="right" ;;
                'D') KEY_PRESSED="left" ;;
                *) KEY_PRESSED="esc" ;;
            esac
        else
            # ESC puro
            KEY_PRESSED="esc"
        fi
    elif [[ "$key" == "" ]]; then
        KEY_PRESSED="enter"
    elif [[ "$key" == " " ]]; then
        KEY_PRESSED="space"
    elif [[ "$key" == "q" || "$key" == "Q" ]]; then
        KEY_PRESSED="quit"
    else
        KEY_PRESSED="$key"
    fi
}

echo "=== TESTE DE DETECÇÃO DE TECLAS ==="
echo "Pressione setas ↑↓←→ ou 'q' para sair"
echo ""

while true; do
    read_key
    echo ">>> Tecla detectada: '$KEY_PRESSED'"
    echo ""

    if [[ "$KEY_PRESSED" == "quit" ]]; then
        echo "Saindo..."
        break
    fi
done
