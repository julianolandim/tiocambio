#!/bin/bash

# Teste FINAL para macOS - simula comportamento exato

KEY_PRESSED=""

read_key() {
    local key=""
    local seq=""
    KEY_PRESSED=""

    # Ler até 3 caracteres (ESC + sequência)
    IFS= read -rsn1 key

    echo "DEBUG: Primeiro byte: $(printf '%q' "$key")"

    # Se for ESC, ler os próximos 2 caracteres juntos
    if [[ "$key" == $'\x1b' ]]; then
        echo "DEBUG: ESC detectado, aguardando próximos 2 bytes com timeout de 1s..."
        # Ler 2 caracteres de uma vez com timeout maior
        IFS= read -rsn2 -t 1 seq 2>/dev/null

        echo "DEBUG: Sequência de 2 bytes lida: $(printf '%q' "$seq")"

        # Processar sequência completa
        case "$seq" in
            '[A'|'OA') KEY_PRESSED="up" ;;
            '[B'|'OB') KEY_PRESSED="down" ;;
            '[C'|'OC') KEY_PRESSED="right" ;;
            '[D'|'OD') KEY_PRESSED="left" ;;
            *)
                # Se não conseguiu ler 2 chars, é ESC puro
                echo "DEBUG: Não conseguiu ler 2 chars ou sequência desconhecida"
                KEY_PRESSED="esc"
                ;;
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
}

echo "=== TESTE FINAL PARA MACOS ==="
echo "Pressione setas ↑↓←→ ou 'q' para sair"
echo ""

while true; do
    read_key
    echo ">>> RESULTADO: Tecla detectada = '$KEY_PRESSED'"
    echo ""

    if [[ "$KEY_PRESSED" == "quit" ]]; then
        echo "Saindo..."
        break
    fi
done
