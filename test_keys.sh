#!/bin/bash

# Script para testar detecção de teclas

echo "Teste de detecção de teclas - Pressione teclas (q para sair):"
echo ""

while true; do
    # Ler tecla
    IFS= read -rsn1 key

    if [[ "$key" == "q" ]]; then
        echo "Saindo..."
        break
    fi

    # Detectar ESC ou setas
    if [[ "$key" == $'\x1b' ]]; then
        IFS= read -rsn1 -t 0.3 key2 2>/dev/null
        IFS= read -rsn1 -t 0.3 key3 2>/dev/null

        if [[ -n "$key2" && -n "$key3" ]]; then
            case "${key2}${key3}" in
                '[A') echo "SETA CIMA detectada!" ;;
                '[B') echo "SETA BAIXO detectada!" ;;
                '[C') echo "SETA DIREITA detectada!" ;;
                '[D') echo "SETA ESQUERDA detectada!" ;;
                *) echo "ESC com sequência: ${key2}${key3}" ;;
            esac
        else
            echo "ESC puro"
        fi
    elif [[ "$key" == "" ]]; then
        echo "ENTER detectado!"
    elif [[ "$key" == " " ]]; then
        echo "ESPAÇO detectado!"
    else
        echo "Tecla: '$key' (código: $(printf '%d' "'$key"))"
    fi
done
