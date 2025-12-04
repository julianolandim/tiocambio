#!/bin/bash

# Script para consultar cotações de moedas
# Versão com seleção de moeda base obrigatória

# Função de ajuda
show_help() {
    echo "=========================================="
    echo "💰  TIO CÂMBIO - CONVERSOR DE MOEDAS"
    echo "=========================================="
    echo ""
    echo "Uso: $0 -<moeda> [opções]"
    echo ""
    echo "MOEDA BASE (OBRIGATÓRIO):"
    echo "  -brl         Cotações em relação ao Real Brasileiro"
    echo "  -usd         Cotações em relação ao Dólar Americano"
    echo "  -eur         Cotações em relação ao Euro"
    echo "  -gbp         Cotações em relação à Libra Esterlina"
    echo "  -jpy         Cotações em relação ao Iene Japonês"
    echo "  -cny         Cotações em relação ao Yuan Chinês"
    echo "  -chf         Cotações em relação ao Franco Suíço"
    echo "  -cad         Cotações em relação ao Dólar Canadense"
    echo "  -aud         Cotações em relação ao Dólar Australiano"
    echo "  -ars         Cotações em relação ao Peso Argentino"
    echo "  -pyg         Cotações em relação ao Guarani Paraguaio"
    echo "  -btc         Cotações em relação ao Bitcoin"
    echo ""
    echo "CONVERSÃO DE VALORES:"
    echo "  -brl <moeda> <valor>    Converte valor da moeda base para outra"
    echo ""
    echo "Exemplos:"
    echo "  $0 -brl                 # Mostra todas as cotações em relação ao Real"
    echo "  $0 -usd                 # Mostra todas as cotações em relação ao Dólar"
    echo "  $0 -brl usd 100         # Converte 100 Reais para Dólares"
    echo "  $0 -usd brl 50          # Converte 50 Dólares para Reais"
    echo "  $0 -eur gbp 200         # Converte 200 Euros para Libras"
    echo ""
    echo "  -h, --help              Mostra esta ajuda"
    echo ""
    exit 0
}

# Função para mostrar menu de seleção
show_currency_menu() {
    echo "=========================================="
    echo "💰  TIO CÂMBIO - SELECIONE A MOEDA BASE"
    echo "=========================================="
    echo ""
    echo "Escolha a moeda base para ver as cotações:"
    echo ""
    echo "  1) 🇧🇷 BRL - Real Brasileiro"
    echo "  2) 💵 USD - Dólar Americano"
    echo "  3) 💶 EUR - Euro"
    echo "  4) 💷 GBP - Libra Esterlina"
    echo "  5) 💴 JPY - Iene Japonês"
    echo "  6) 🇨🇳 CNY - Yuan Chinês"
    echo "  7) 🇨🇭 CHF - Franco Suíço"
    echo "  8) 🇨🇦 CAD - Dólar Canadense"
    echo "  9) 🇦🇺 AUD - Dólar Australiano"
    echo " 10) 🇦🇷 ARS - Peso Argentino"
    echo " 11) 🇵🇾 PYG - Guarani Paraguaio"
    echo " 12) ₿  BTC - Bitcoin"
    echo "  0) ❌ Sair"
    echo ""
    echo -n "Digite o número da moeda: "
    read choice

    case $choice in
        1) BASE_CURRENCY="BRL" ;;
        2) BASE_CURRENCY="USD" ;;
        3) BASE_CURRENCY="EUR" ;;
        4) BASE_CURRENCY="GBP" ;;
        5) BASE_CURRENCY="JPY" ;;
        6) BASE_CURRENCY="CNY" ;;
        7) BASE_CURRENCY="CHF" ;;
        8) BASE_CURRENCY="CAD" ;;
        9) BASE_CURRENCY="AUD" ;;
        10) BASE_CURRENCY="ARS" ;;
        11) BASE_CURRENCY="PYG" ;;
        12) BASE_CURRENCY="BTC" ;;
        0) echo "Até logo!"; exit 0 ;;
        *) echo "❌ Opção inválida!"; exit 1 ;;
    esac
}

# Função para obter nome e emoji da moeda
get_currency_info() {
    local currency=$1
    case $currency in
        BRL) echo "Real Brasileiro|🇧🇷" ;;
        USD) echo "Dólar Americano|💵" ;;
        EUR) echo "Euro|💶" ;;
        GBP) echo "Libra Esterlina|💷" ;;
        JPY) echo "Iene Japonês|💴" ;;
        CNY) echo "Yuan Chinês|🇨🇳" ;;
        CHF) echo "Franco Suíço|🇨🇭" ;;
        CAD) echo "Dólar Canadense|🇨🇦" ;;
        AUD) echo "Dólar Australiano|🇦🇺" ;;
        ARS) echo "Peso Argentino|🇦🇷" ;;
        PYG) echo "Guarani Paraguaio|🇵🇾" ;;
        BTC) echo "Bitcoin|₿" ;;
    esac
}

# Função para obter cotação de Bitcoin
get_btc_rate() {
    local base_currency=$1

    # Usa CoinGecko API para Bitcoin
    response=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=${base_currency}")

    if [ $? -eq 0 ]; then
        # Extrai o valor do JSON
        rate=$(echo $response | grep -o "\"$(echo $base_currency | tr '[:upper:]' '[:lower:]')\":[0-9.]*" | cut -d':' -f2)

        if [ -n "$rate" ]; then
            base_info=$(get_currency_info $base_currency)
            base_symbol=$(echo $base_info | cut -d'|' -f1)
            echo "₿ 1 Bitcoin = ${rate} ${base_symbol}"
        else
            echo "❌ Erro ao obter cotação de Bitcoin"
        fi
    else
        echo "❌ Erro de conexão ao buscar Bitcoin"
    fi
}

# Função para obter cotação
get_exchange_rate() {
    local base_currency=$1
    local target_currency=$2
    local target_name=$3
    local emoji=$4

    # Se o target for Bitcoin, usa função específica
    if [ "$target_currency" = "BTC" ]; then
        get_btc_rate "$base_currency"
        return
    fi

    # Busca a taxa inversa: quanto custa 1 unidade da moeda alvo na moeda base
    response=$(curl -s "https://api.exchangerate-api.com/v4/latest/${target_currency}")

    if [ $? -eq 0 ]; then
        rate=$(echo $response | grep -o "\"${base_currency}\":[0-9.]*" | cut -d':' -f2)

        if [ -n "$rate" ]; then
            base_info=$(get_currency_info $base_currency)
            base_symbol=$(echo $base_info | cut -d'|' -f1)
            echo "$emoji 1 ${target_name} = ${rate} ${base_symbol}"
        else
            echo "❌ Erro ao obter cotação de ${target_name}"
        fi
    else
        echo "❌ Erro de conexão ao buscar ${target_name}"
    fi
}

# Função para converter valor
convert_value() {
    local from=$1
    local to=$2
    local amount=$3

    from_info=$(get_currency_info $from)
    to_info=$(get_currency_info $to)

    from_name=$(echo $from_info | cut -d'|' -f1)
    from_emoji=$(echo $from_info | cut -d'|' -f2)
    to_name=$(echo $to_info | cut -d'|' -f1)
    to_emoji=$(echo $to_info | cut -d'|' -f2)

    # Se envolver Bitcoin, usa CoinGecko API
    if [ "$from" = "BTC" ] || [ "$to" = "BTC" ]; then
        if [ "$from" = "BTC" ]; then
            # Converte de BTC para outra moeda
            response=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=$(echo $to | tr '[:upper:]' '[:lower:]')")
            rate=$(echo $response | grep -o "\"$(echo $to | tr '[:upper:]' '[:lower:]')\":[0-9.]*" | cut -d':' -f2)
        else
            # Converte de outra moeda para BTC
            response=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=$(echo $from | tr '[:upper:]' '[:lower:]')")
            btc_rate=$(echo $response | grep -o "\"$(echo $from | tr '[:upper:]' '[:lower:]')\":[0-9.]*" | cut -d':' -f2)
            if [ -n "$btc_rate" ]; then
                rate=$(echo "scale=8; 1 / $btc_rate" | bc)
            fi
        fi

        if [ -n "$rate" ]; then
            if [ "$from" = "BTC" ]; then
                result=$(echo "scale=2; $amount * $rate" | bc)
            else
                result=$(echo "scale=8; $amount * $rate" | bc)
            fi
            echo "$from_emoji $amount $from_name = $to_emoji $result $to_name"
        else
            echo "❌ Erro ao obter taxa de conversão"
        fi
        return
    fi

    # Conversão normal para moedas tradicionais
    response=$(curl -s "https://api.exchangerate-api.com/v4/latest/${from}")

    if [ $? -eq 0 ]; then
        rate=$(echo $response | grep -o "\"${to}\":[0-9.]*" | cut -d':' -f2)

        if [ -n "$rate" ]; then
            result=$(echo "scale=2; $amount * $rate" | bc)
            echo "$from_emoji $amount $from_name = $to_emoji $result $to_name"
        else
            echo "❌ Erro ao obter taxa de conversão"
        fi
    else
        echo "❌ Erro de conexão"
    fi
}

# Função para mostrar todas as cotações em relação à moeda base
show_all_rates() {
    local base_currency=$1

    base_info=$(get_currency_info $base_currency)
    base_name=$(echo $base_info | cut -d'|' -f1)
    base_emoji=$(echo $base_info | cut -d'|' -f2)

    echo "=========================================="
    echo "$base_emoji  QUANTO CUSTAM AS MOEDAS EM $base_name"
    echo "=========================================="
    echo ""

    # Buscar dólar paralelo se a base for BRL
    if [ "$base_currency" = "BRL" ]; then
        echo "💵 AMÉRICAS"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        get_exchange_rate "$base_currency" "USD" "Dólar Americano (EUA)" "💵"

        dolar_paralelo=$(curl -s "https://economia.awesomeapi.com.br/json/last/USD-BRL" | grep -o '"high":"[0-9.]*"' | head -1 | cut -d'"' -f4)
        if [ -n "$dolar_paralelo" ]; then
            echo "💸 1 Dólar Paralelo (Turismo) = ${dolar_paralelo}"
        fi

        get_exchange_rate "$base_currency" "CAD" "Dólar Canadense" "🇨🇦"
        get_exchange_rate "$base_currency" "ARS" "Peso Argentino" "🇦🇷"
        get_exchange_rate "$base_currency" "PYG" "Guarani Paraguaio" "🇵🇾"

        echo ""
        echo "💶 EUROPA"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        get_exchange_rate "$base_currency" "EUR" "Euro" "💶"
        get_exchange_rate "$base_currency" "GBP" "Libra Esterlina (Reino Unido)" "💷"
        get_exchange_rate "$base_currency" "CHF" "Franco Suíço" "🇨🇭"

        echo ""
        echo "🌏 ÁSIA E OCEANIA"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        get_exchange_rate "$base_currency" "JPY" "Iene Japonês" "💴"
        get_exchange_rate "$base_currency" "CNY" "Yuan Chinês" "🇨🇳"
        get_exchange_rate "$base_currency" "AUD" "Dólar Australiano" "🇦🇺"

        echo ""
        echo "₿ CRIPTOMOEDAS"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        get_exchange_rate "$base_currency" "BTC" "Bitcoin" "₿"
    else
        # Para outras moedas base, mostrar todas as moedas
        echo "💰 PRINCIPAIS MOEDAS"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

        # Não mostrar a própria moeda base
        [ "$base_currency" != "BRL" ] && get_exchange_rate "$base_currency" "BRL" "Real Brasileiro" "🇧🇷"
        [ "$base_currency" != "USD" ] && get_exchange_rate "$base_currency" "USD" "Dólar Americano" "💵"
        [ "$base_currency" != "EUR" ] && get_exchange_rate "$base_currency" "EUR" "Euro" "💶"
        [ "$base_currency" != "GBP" ] && get_exchange_rate "$base_currency" "GBP" "Libra Esterlina" "💷"
        [ "$base_currency" != "JPY" ] && get_exchange_rate "$base_currency" "JPY" "Iene Japonês" "💴"
        [ "$base_currency" != "CNY" ] && get_exchange_rate "$base_currency" "CNY" "Yuan Chinês" "🇨🇳"
        [ "$base_currency" != "CHF" ] && get_exchange_rate "$base_currency" "CHF" "Franco Suíço" "🇨🇭"
        [ "$base_currency" != "CAD" ] && get_exchange_rate "$base_currency" "CAD" "Dólar Canadense" "🇨🇦"
        [ "$base_currency" != "AUD" ] && get_exchange_rate "$base_currency" "AUD" "Dólar Australiano" "🇦🇺"
        [ "$base_currency" != "ARS" ] && get_exchange_rate "$base_currency" "ARS" "Peso Argentino" "🇦🇷"
        [ "$base_currency" != "PYG" ] && get_exchange_rate "$base_currency" "PYG" "Guarani Paraguaio" "🇵🇾"
        [ "$base_currency" != "BTC" ] && get_exchange_rate "$base_currency" "BTC" "Bitcoin" "₿"
    fi

    echo ""
    echo "=========================================="
    echo "🕐 Consulta realizada em: $(date '+%d/%m/%Y %H:%M:%S')"
    echo "=========================================="
}

# Processa argumentos
if [ $# -eq 0 ]; then
    # Sem argumentos - mostra menu
    show_currency_menu
    show_all_rates "$BASE_CURRENCY"
    exit 0
fi

# Processa primeiro argumento
case "$1" in
    -h|--help)
        show_help
        ;;
    -brl)
        if [ -n "$2" ] && [ -n "$3" ]; then
            # Modo conversão: -brl usd 100
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "BRL" "$target_currency" "$3"
        else
            # Modo cotação: -brl
            show_all_rates "BRL"
        fi
        ;;
    -usd)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "USD" "$target_currency" "$3"
        else
            show_all_rates "USD"
        fi
        ;;
    -eur)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "EUR" "$target_currency" "$3"
        else
            show_all_rates "EUR"
        fi
        ;;
    -gbp)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "GBP" "$target_currency" "$3"
        else
            show_all_rates "GBP"
        fi
        ;;
    -jpy)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "JPY" "$target_currency" "$3"
        else
            show_all_rates "JPY"
        fi
        ;;
    -cny)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "CNY" "$target_currency" "$3"
        else
            show_all_rates "CNY"
        fi
        ;;
    -chf)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "CHF" "$target_currency" "$3"
        else
            show_all_rates "CHF"
        fi
        ;;
    -cad)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "CAD" "$target_currency" "$3"
        else
            show_all_rates "CAD"
        fi
        ;;
    -aud)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "AUD" "$target_currency" "$3"
        else
            show_all_rates "AUD"
        fi
        ;;
    -ars)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "ARS" "$target_currency" "$3"
        else
            show_all_rates "ARS"
        fi
        ;;
    -pyg)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "PYG" "$target_currency" "$3"
        else
            show_all_rates "PYG"
        fi
        ;;
    -btc)
        if [ -n "$2" ] && [ -n "$3" ]; then
            target_currency=$(echo "$2" | tr '[:lower:]' '[:upper:]')
            convert_value "BTC" "$target_currency" "$3"
        else
            show_all_rates "BTC"
        fi
        ;;
    *)
        echo "❌ Opção inválida: $1"
        echo ""
        echo "Você deve especificar uma moeda base."
        echo "Use -h ou --help para ver as opções disponíveis"
        echo ""
        show_currency_menu
        show_all_rates "$BASE_CURRENCY"
        ;;
esac
