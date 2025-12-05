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
    echo "ALERTAS DE PREÇO:"
    echo "  --btc-alert <moeda> <valor_min> <valor_max>  Monitora preço do Bitcoin"
    echo "      Exemplo: $0 --btc-alert brl 450000 500000"
    echo "  --alert <moeda_origem> <moeda_destino> <valor_min> <valor_max>"
    echo "      Monitora qualquer conversão de moeda"
    echo "      Exemplo: $0 --alert usd brl 5.0 5.5"
    echo "      (Alerta quando 1 USD estiver entre R$ 5.00 e R$ 5.50)"
    echo ""
    echo "Exemplos:"
    echo "  $0 -brl                 # Mostra todas as cotações em relação ao Real"
    echo "  $0 -usd                 # Mostra todas as cotações em relação ao Dólar"
    echo "  $0 -brl usd 100         # Converte 100 Reais para Dólares"
    echo "  $0 -usd brl 50          # Converte 50 Dólares para Reais"
    echo "  $0 -eur gbp 200         # Converte 200 Euros para Libras"
    echo "  $0 --btc-alert brl 480000 520000  # Alerta de Bitcoin"
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

# Função para formatar valores monetários seguindo padrão de cada país
format_currency() {
    local value=$1
    local currency=$2

    # Usar script Python para formatação (mais confiável)
    python3 ./format_money.py "$value" "$currency"
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
            formatted_rate=$(format_currency "$rate" "$base_currency")
            echo "₿ 1 Bitcoin = ${formatted_rate} ${base_symbol}"
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
            formatted_rate=$(format_currency "$rate" "$base_currency")
            echo "$emoji 1 ${target_name} = ${formatted_rate} ${base_symbol}"
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
                formatted_amount=$(format_currency "$amount" "BTC")
                formatted_result=$(format_currency "$result" "$to")
            else
                result=$(echo "scale=8; $amount * $rate" | bc)
                formatted_amount=$(format_currency "$amount" "$from")
                formatted_result=$(format_currency "$result" "BTC")
            fi
            echo "$from_emoji $formatted_amount $from_name = $to_emoji $formatted_result $to_name"
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
            formatted_amount=$(format_currency "$amount" "$from")
            formatted_result=$(format_currency "$result" "$to")
            echo "$from_emoji $formatted_amount $from_name = $to_emoji $formatted_result $to_name"
        else
            echo "❌ Erro ao obter taxa de conversão"
        fi
    else
        echo "❌ Erro de conexão"
    fi
}

# Função para monitorar preço do Bitcoin
btc_price_alert() {
    local currency=$1
    local min_price=$2
    local max_price=$3
    local interval=60  # Intervalo de 60 segundos entre verificações

    currency_upper=$(echo "$currency" | tr '[:lower:]' '[:upper:]')
    currency_info=$(get_currency_info $currency_upper)
    currency_name=$(echo $currency_info | cut -d'|' -f1)
    currency_emoji=$(echo $currency_info | cut -d'|' -f2)

    echo "=========================================="
    echo "₿  ALERTA DE PREÇO DO BITCOIN"
    echo "=========================================="
    echo ""
    echo "Moeda: $currency_emoji $currency_name"
    echo "Faixa de alerta: $min_price - $max_price"
    echo "Intervalo de verificação: ${interval}s"
    echo ""
    echo "Pressione Ctrl+C para parar o monitoramento"
    echo "=========================================="
    echo ""

    # Loop infinito de monitoramento
    while true; do
        # Busca preço atual do Bitcoin
        response=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=$(echo $currency_upper | tr '[:upper:]' '[:lower:]')")
        current_price=$(echo $response | grep -o "\"$(echo $currency_upper | tr '[:upper:]' '[:lower:]')\":[0-9.]*" | cut -d':' -f2)

        if [ -n "$current_price" ]; then
            timestamp=$(date '+%d/%m/%Y %H:%M:%S')

            # Converte para inteiro para comparação (remove decimais)
            current_int=$(echo $current_price | cut -d'.' -f1)

            # Verifica se está dentro da faixa
            formatted_price=$(format_currency "$current_price" "$currency_upper")
            if [ "$current_int" -ge "$min_price" ] && [ "$current_int" -le "$max_price" ]; then
                echo "🔔 [$timestamp] ALERTA! Bitcoin: $currency_emoji $formatted_price $currency_name (DENTRO DA FAIXA)"
                # Emite beep (se suportado pelo terminal)
                printf '\a'
            else
                if [ "$current_int" -lt "$min_price" ]; then
                    status="ABAIXO"
                else
                    status="ACIMA"
                fi
                echo "⏱️  [$timestamp] Bitcoin: $currency_emoji $formatted_price $currency_name ($status da faixa)"
            fi
        else
            echo "❌ [$timestamp] Erro ao obter cotação do Bitcoin"
        fi

        # Aguarda antes da próxima verificação
        sleep $interval
    done
}

# Função para monitorar conversão entre duas moedas
currency_pair_alert() {
    local from_currency=$1
    local to_currency=$2
    local min_price=$3
    local max_price=$4
    local interval=60  # Intervalo de 60 segundos entre verificações

    from_upper=$(echo "$from_currency" | tr '[:lower:]' '[:upper:]')
    to_upper=$(echo "$to_currency" | tr '[:lower:]' '[:upper:]')

    from_info=$(get_currency_info $from_upper)
    to_info=$(get_currency_info $to_upper)

    from_name=$(echo $from_info | cut -d'|' -f1)
    from_emoji=$(echo $from_info | cut -d'|' -f2)
    to_name=$(echo $to_info | cut -d'|' -f1)
    to_emoji=$(echo $to_info | cut -d'|' -f2)

    echo "=========================================="
    echo "💱  ALERTA DE CONVERSÃO DE MOEDAS"
    echo "=========================================="
    echo ""
    echo "Conversão: $from_emoji $from_name → $to_emoji $to_name"
    echo "Faixa de alerta: $min_price - $max_price"
    echo "Intervalo de verificação: ${interval}s"
    echo ""
    echo "Pressione Ctrl+C para parar o monitoramento"
    echo "=========================================="
    echo ""

    # Loop infinito de monitoramento
    while true; do
        timestamp=$(date '+%d/%m/%Y %H:%M:%S')

        # Busca taxa de conversão
        if [ "$from_upper" = "BTC" ] || [ "$to_upper" = "BTC" ]; then
            # Conversão envolvendo Bitcoin
            if [ "$from_upper" = "BTC" ]; then
                response=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=$(echo $to_upper | tr '[:upper:]' '[:lower:]')")
                current_rate=$(echo $response | grep -o "\"$(echo $to_upper | tr '[:upper:]' '[:lower:]')\":[0-9.]*" | cut -d':' -f2)
            else
                response=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=$(echo $from_upper | tr '[:upper:]' '[:lower:]')")
                btc_rate=$(echo $response | grep -o "\"$(echo $from_upper | tr '[:upper:]' '[:lower:]')\":[0-9.]*" | cut -d':' -f2)
                if [ -n "$btc_rate" ]; then
                    current_rate=$(echo "scale=8; 1 / $btc_rate" | bc)
                fi
            fi
        else
            # Conversão normal entre moedas tradicionais
            response=$(curl -s "https://api.exchangerate-api.com/v4/latest/${from_upper}")
            current_rate=$(echo $response | grep -o "\"${to_upper}\":[0-9.]*" | cut -d':' -f2)
        fi

        if [ -n "$current_rate" ]; then
            # Para comparação, pega apenas a parte inteira ou converte para escala comparável
            # Usa bc para comparação com decimais
            formatted_rate=$(format_currency "$current_rate" "$to_upper")
            if [ "$(echo "$current_rate >= $min_price" | bc)" -eq 1 ] && [ "$(echo "$current_rate <= $max_price" | bc)" -eq 1 ]; then
                echo "🔔 [$timestamp] ALERTA! 1 $from_emoji $from_upper = $to_emoji $formatted_rate $to_upper (DENTRO DA FAIXA)"
                # Emite beep (se suportado pelo terminal)
                printf '\a'
            else
                if [ "$(echo "$current_rate < $min_price" | bc)" -eq 1 ]; then
                    status="ABAIXO"
                else
                    status="ACIMA"
                fi
                echo "⏱️  [$timestamp] 1 $from_emoji $from_upper = $to_emoji $formatted_rate $to_upper ($status da faixa)"
            fi
        else
            echo "❌ [$timestamp] Erro ao obter taxa de conversão"
        fi

        # Aguarda antes da próxima verificação
        sleep $interval
    done
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
            formatted_paralelo=$(format_currency "$dolar_paralelo" "BRL")
            echo "💸 1 Dólar Paralelo (Turismo) = ${formatted_paralelo}"
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
    --btc-alert)
        if [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
            echo "❌ Erro: Uso correto: $0 --btc-alert <moeda> <valor_min> <valor_max>"
            echo "Exemplo: $0 --btc-alert brl 450000 500000"
            exit 1
        fi
        btc_price_alert "$2" "$3" "$4"
        ;;
    --alert)
        if [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
            echo "❌ Erro: Uso correto: $0 --alert <moeda_origem> <moeda_destino> <valor_min> <valor_max>"
            echo "Exemplo: $0 --alert usd brl 5.0 5.5"
            echo "         (Alerta quando 1 USD estiver entre R$ 5.00 e R$ 5.50)"
            exit 1
        fi
        currency_pair_alert "$2" "$3" "$4" "$5"
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
