#!/bin/bash

# Teste de comprimento de strings

test_string() {
    local str="$1"
    local clean="$str"
    
    # Remove ANSI
    while [[ "$clean" =~ $'\033'\[[0-9\;]*m ]]; do
        clean="${clean//${BASH_REMATCH[0]}/}"
    done
    
    echo "String: $str"
    echo "Clean: $clean"
    echo "Comprimento clean: ${#clean}"
    echo "Bytes: $(printf "%s" "$clean" | wc -c | tr -d ' ')"
    echo "Chars: $(printf "%s" "$clean" | wc -m | tr -d ' ')"
    echo "---"
}

test_string "MENU PRINCIPAL"
test_string "TIO CÂMBIO - CONVERSOR DE MOEDAS"
test_string "Ver Cotações"
test_string "Converter Moedas"
test_string "\033[1m\033[1;37mMENU PRINCIPAL\033[0m"
test_string "\033[0;36m2. Converter Moedas\033[0m"
