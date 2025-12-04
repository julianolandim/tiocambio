#!/bin/bash

# TIO CÂMBIO - Terminal User Interface (TUI)
# Interface gráfica para terminal usando caracteres ASCII

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

# Configurações
SCRIPT_PATH="./tiocambio.sh"
TEMP_FILE="/tmp/tiocambio_tui_$$"
SELECTED_CURRENCY=""
KEY_PRESSED=""

# Função para limpar a tela
clear_screen() {
    clear
    tput cup 0 0
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

# Função para desenhar linha vazia
draw_empty_line() {
    local width=${1:-80}
    echo -ne "${CYAN}║${RESET}"
    for ((i=0; i<width-2; i++)); do echo -n " "; done
    echo -e "${CYAN}║${RESET}"
}

# Função para desenhar divisor
draw_divider() {
    local width=${1:-80}
    echo -ne "${CYAN}╠"
    for ((i=0; i<width-2; i++)); do echo -n "═"; done
    echo -e "╣${RESET}"
}

# Função para desenhar cabeçalho
draw_header() {
    clear_screen
    draw_top_border 80
    draw_empty_line 80
    draw_line "${BOLD}${YELLOW}💰  TIO CÂMBIO - CONVERSOR DE MOEDAS  💰${RESET}" 80
    draw_empty_line 80
    draw_divider 80
}

# Função para desenhar rodapé
draw_footer() {
    draw_divider 80
    draw_empty_line 80
    draw_line "${CYAN}Use as setas ↑↓ ou números para navegar | ${WHITE}ESC${CYAN} ou ${WHITE}q${CYAN} para sair${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80
}

# Função para desenhar menu
draw_menu() {
    local selected=$1
    local -a options=(
        "📊 Ver Cotações"
        "💱 Converter Moedas"
        "🔔 Configurar Alertas"
        "📈 Ver Alertas Ativos"
        "❓ Ajuda"
        "❌ Sair"
    )

    draw_empty_line 80
    draw_line "${BOLD}${WHITE}MENU PRINCIPAL${RESET}" 80
    draw_empty_line 80

    for i in "${!options[@]}"; do
        if [ $i -eq $selected ]; then
            draw_line "    ${GREEN}▶ ${WHITE}${BOLD}$((i+1)). ${options[$i]}${RESET}" 80
        else
            draw_line "      ${CYAN}$((i+1)). ${options[$i]}${RESET}" 80
        fi
    done

    draw_empty_line 80
}

# Função para limpar buffer de entrada
flush_input() {
    while read -rsn1 -t 0.1 2>/dev/null; do :; done
}

# Função para ler tecla (usa variável global KEY_PRESSED)
read_key() {
    local key=""
    KEY_PRESSED=""

    # Ler primeiro caractere
    IFS= read -rsn1 key

    # Detectar ESC ou setas
    if [[ "$key" == $'\x1b' ]]; then
        # Ler sequência completa de 2 caracteres
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
}

# Função para esperar tecla (mantida para compatibilidade)
wait_key() {
    read_key
    echo "$KEY_PRESSED"
}

# Função para selecionar moeda
select_currency() {
    local prompt="$1"
    local selected=0
    local currencies=(
        "🇧🇷 BRL - Real Brasileiro"
        "💵 USD - Dólar Americano"
        "💶 EUR - Euro"
        "💷 GBP - Libra Esterlina"
        "💴 JPY - Iene Japonês"
        "🇨🇳 CNY - Yuan Chinês"
        "🇨🇭 CHF - Franco Suíço"
        "🇨🇦 CAD - Dólar Canadense"
        "🇦🇺 AUD - Dólar Australiano"
        "🇦🇷 ARS - Peso Argentino"
        "🇵🇾 PYG - Guarani Paraguaio"
        "₿  BTC - Bitcoin"
    )
    local codes=("BRL" "USD" "EUR" "GBP" "JPY" "CNY" "CHF" "CAD" "AUD" "ARS" "PYG" "BTC")

    SELECTED_CURRENCY=""
    flush_input

    while true; do
        draw_header
        draw_empty_line 80
        draw_line "${BOLD}${WHITE}$prompt${RESET}" 80
        draw_empty_line 80

        for i in "${!currencies[@]}"; do
            if [ $i -eq $selected ]; then
                draw_line "    ${GREEN}▶ ${WHITE}${BOLD}${currencies[$i]}${RESET}" 80
            else
                draw_line "      ${CYAN}${currencies[$i]}${RESET}" 80
            fi
        done

        draw_empty_line 80
        draw_footer

        read_key

        case "$KEY_PRESSED" in
            up)
                ((selected--))
                [ $selected -lt 0 ] && selected=$((${#currencies[@]}-1))
                ;;
            down)
                ((selected++))
                [ $selected -ge ${#currencies[@]} ] && selected=0
                ;;
            enter|space)
                SELECTED_CURRENCY="${codes[$selected]}"
                flush_input
                return 0
                ;;
            [1-9])
                if [ "$KEY_PRESSED" -le ${#currencies[@]} ]; then
                    SELECTED_CURRENCY="${codes[$((KEY_PRESSED-1))]}"
                    flush_input
                    return 0
                fi
                ;;
            quit|esc)
                SELECTED_CURRENCY=""
                flush_input
                return 1
                ;;
        esac
    done
}

# Função para mostrar cotações
show_quotes() {
    select_currency "Selecione a moeda base:"
    if [ $? -ne 0 ] || [ -z "$SELECTED_CURRENCY" ]; then
        return
    fi

    local base_currency="$SELECTED_CURRENCY"

    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${YELLOW}Buscando cotações...${RESET}" 80
    draw_empty_line 80
    draw_footer

    # Executar script e capturar saída
    $SCRIPT_PATH -${base_currency,,} > $TEMP_FILE 2>&1

    # Mostrar resultado
    draw_header
    draw_empty_line 80

    # Ler e exibir linha por linha
    local line_count=0
    while IFS= read -r line; do
        if [ ${#line} -gt 76 ]; then
            line="${line:0:76}"
        fi
        draw_line "$line" 80
        ((line_count++))
        if [ $line_count -ge 20 ]; then
            break
        fi
    done < $TEMP_FILE

    draw_empty_line 80
    draw_divider 80
    draw_empty_line 80
    draw_line "${WHITE}Pressione qualquer tecla para continuar...${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    flush_input
    read -rsn1
}

# Função para converter moedas
convert_currency() {
    # Selecionar moeda de origem
    select_currency "Selecione a moeda DE (origem):"
    if [ $? -ne 0 ] || [ -z "$SELECTED_CURRENCY" ]; then return; fi
    local from_currency="$SELECTED_CURRENCY"

    # Selecionar moeda de destino
    select_currency "Selecione a moeda PARA (destino):"
    if [ $? -ne 0 ] || [ -z "$SELECTED_CURRENCY" ]; then return; fi
    local to_currency="$SELECTED_CURRENCY"

    # Pedir valor
    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${WHITE}CONVERSÃO: ${from_currency} → ${to_currency}${RESET}" 80
    draw_empty_line 80
    draw_line "${CYAN}Digite o valor a converter:${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    flush_input
    echo -ne "\n${YELLOW}Valor: ${WHITE}"
    read amount
    echo -ne "${RESET}"

    # Validar valor
    if ! [[ "$amount" =~ ^[0-9]+\.?[0-9]*$ ]]; then
        draw_header
        draw_empty_line 80
        draw_line "${RED}❌ Valor inválido!${RESET}" 80
        draw_empty_line 80
        draw_line "${WHITE}Pressione qualquer tecla para continuar...${RESET}" 80
        draw_empty_line 80
        draw_bottom_border 80
        flush_input
        read -rsn1
        return
    fi

    # Executar conversão
    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${YELLOW}Convertendo...${RESET}" 80
    draw_empty_line 80
    draw_footer

    result=$($SCRIPT_PATH -${from_currency,,} ${to_currency,,} $amount 2>&1)

    # Mostrar resultado
    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${WHITE}RESULTADO DA CONVERSÃO${RESET}" 80
    draw_empty_line 80
    draw_line "${GREEN}$result${RESET}" 80
    draw_empty_line 80
    draw_divider 80
    draw_empty_line 80
    draw_line "${WHITE}Pressione qualquer tecla para continuar...${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    flush_input
    read -rsn1
}

# Função para configurar alertas
configure_alert() {
    # Menu de tipo de alerta
    local selected=0
    local -a options=("Par de Moedas" "Bitcoin" "Voltar")

    while true; do
        draw_header
        draw_empty_line 80
        draw_line "${BOLD}${WHITE}TIPO DE ALERTA${RESET}" 80
        draw_empty_line 80

        for i in "${!options[@]}"; do
            if [ $i -eq $selected ]; then
                draw_line "    ${GREEN}▶ ${WHITE}${BOLD}${options[$i]}${RESET}" 80
            else
                draw_line "      ${CYAN}${options[$i]}${RESET}" 80
            fi
        done

        draw_empty_line 80
        draw_footer

        read_key

        case "$KEY_PRESSED" in
            up)
                ((selected--))
                [ $selected -lt 0 ] && selected=$((${#options[@]}-1))
                ;;
            down)
                ((selected++))
                [ $selected -ge ${#options[@]} ] && selected=0
                ;;
            enter|space)
                flush_input
                case $selected in
                    0) configure_pair_alert ;;
                    1) configure_btc_alert ;;
                    2) return ;;
                esac
                ;;
            quit|esc)
                return
                ;;
        esac
    done
}

# Função para configurar alerta de par de moedas
configure_pair_alert() {
    select_currency "Selecione a moeda DE (origem):"
    if [ $? -ne 0 ] || [ -z "$SELECTED_CURRENCY" ]; then return; fi
    local from_currency="$SELECTED_CURRENCY"

    select_currency "Selecione a moeda PARA (destino):"
    if [ $? -ne 0 ] || [ -z "$SELECTED_CURRENCY" ]; then return; fi
    local to_currency="$SELECTED_CURRENCY"

    # Pedir valores
    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${WHITE}ALERTA: ${from_currency} → ${to_currency}${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    echo -ne "\n${CYAN}Valor mínimo: ${WHITE}"
    read min_val
    echo -ne "${CYAN}Valor máximo: ${WHITE}"
    read max_val
    echo -ne "${RESET}"

    # Confirmar
    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${WHITE}CONFIRMAR ALERTA${RESET}" 80
    draw_empty_line 80
    draw_line "${CYAN}Conversão: ${WHITE}${from_currency} → ${to_currency}${RESET}" 80
    draw_line "${CYAN}Faixa: ${WHITE}${min_val} - ${max_val}${RESET}" 80
    draw_empty_line 80
    draw_line "${YELLOW}O alerta será executado em background.${RESET}" 80
    draw_line "${YELLOW}Use a opção 'Ver Alertas Ativos' para gerenciar.${RESET}" 80
    draw_empty_line 80
    draw_divider 80
    draw_empty_line 80
    draw_line "${WHITE}Pressione ENTER para iniciar ou ESC para cancelar${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    key=$(wait_key)
    if [[ "$key" == "" ]]; then
        # Iniciar alerta em background
        nohup $SCRIPT_PATH --alert ${from_currency,,} ${to_currency,,} $min_val $max_val > "/tmp/alert_${from_currency}_${to_currency}_$$.log" 2>&1 &
        local pid=$!
        echo "$pid|$from_currency|$to_currency|$min_val|$max_val" >> /tmp/tiocambio_alerts.txt

        draw_header
        draw_empty_line 80
        draw_line "${GREEN}✅ Alerta iniciado com sucesso!${RESET}" 80
        draw_line "${CYAN}PID: ${WHITE}$pid${RESET}" 80
        draw_empty_line 80
        draw_line "${WHITE}Pressione qualquer tecla para continuar...${RESET}" 80
        draw_empty_line 80
        draw_bottom_border 80
        read -rsn1
    fi
}

# Função para configurar alerta de Bitcoin
configure_btc_alert() {
    select_currency "Selecione a moeda para monitorar Bitcoin:"
    if [ $? -ne 0 ] || [ -z "$SELECTED_CURRENCY" ]; then return; fi
    local currency="$SELECTED_CURRENCY"

    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${WHITE}ALERTA DE BITCOIN EM ${currency}${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    echo -ne "\n${CYAN}Valor mínimo: ${WHITE}"
    read min_val
    echo -ne "${CYAN}Valor máximo: ${WHITE}"
    read max_val
    echo -ne "${RESET}"

    # Confirmar
    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${WHITE}CONFIRMAR ALERTA DE BITCOIN${RESET}" 80
    draw_empty_line 80
    draw_line "${CYAN}Moeda: ${WHITE}${currency}${RESET}" 80
    draw_line "${CYAN}Faixa: ${WHITE}${min_val} - ${max_val}${RESET}" 80
    draw_empty_line 80
    draw_line "${YELLOW}O alerta será executado em background.${RESET}" 80
    draw_empty_line 80
    draw_divider 80
    draw_empty_line 80
    draw_line "${WHITE}Pressione ENTER para iniciar ou ESC para cancelar${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    key=$(wait_key)
    if [[ "$key" == "" ]]; then
        nohup $SCRIPT_PATH --btc-alert ${currency,,} $min_val $max_val > "/tmp/alert_btc_${currency}_$$.log" 2>&1 &
        local pid=$!
        echo "$pid|BTC|$currency|$min_val|$max_val" >> /tmp/tiocambio_alerts.txt

        draw_header
        draw_empty_line 80
        draw_line "${GREEN}✅ Alerta de Bitcoin iniciado!${RESET}" 80
        draw_line "${CYAN}PID: ${WHITE}$pid${RESET}" 80
        draw_empty_line 80
        draw_line "${WHITE}Pressione qualquer tecla para continuar...${RESET}" 80
        draw_empty_line 80
        draw_bottom_border 80
        read -rsn1
    fi
}

# Função para ver alertas ativos
view_alerts() {
    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${WHITE}ALERTAS ATIVOS${RESET}" 80
    draw_empty_line 80

    if [ ! -f /tmp/tiocambio_alerts.txt ]; then
        draw_line "${YELLOW}Nenhum alerta configurado${RESET}" 80
    else
        # Limpar alertas mortos
        while IFS='|' read -r pid from to min max; do
            if ps -p $pid > /dev/null 2>&1; then
                draw_line "${GREEN}✓${RESET} ${CYAN}PID $pid:${WHITE} $from → $to ${CYAN}($min - $max)${RESET}" 80
            fi
        done < /tmp/tiocambio_alerts.txt
    fi

    draw_empty_line 80
    draw_divider 80
    draw_empty_line 80
    draw_line "${RED}Pressione 'k' para matar todos os alertas ou qualquer tecla para voltar${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    key=$(wait_key)
    if [[ "$key" == "k" ]]; then
        if [ -f /tmp/tiocambio_alerts.txt ]; then
            while IFS='|' read -r pid _; do
                kill $pid 2>/dev/null
            done < /tmp/tiocambio_alerts.txt
            rm -f /tmp/tiocambio_alerts.txt
        fi

        draw_header
        draw_empty_line 80
        draw_line "${GREEN}✅ Todos os alertas foram parados${RESET}" 80
        draw_empty_line 80
        draw_line "${WHITE}Pressione qualquer tecla para continuar...${RESET}" 80
        draw_empty_line 80
        draw_bottom_border 80
        read -rsn1
    fi
}

# Função para mostrar ajuda
show_help() {
    draw_header
    draw_empty_line 80
    draw_line "${BOLD}${WHITE}AJUDA - TIO CÂMBIO${RESET}" 80
    draw_empty_line 80
    draw_line "${CYAN}📊 Ver Cotações:${WHITE} Consulta cotações em tempo real${RESET}" 80
    draw_line "${CYAN}💱 Converter:${WHITE} Converte valores entre moedas${RESET}" 80
    draw_line "${CYAN}🔔 Alertas:${WHITE} Configura monitoramento de preços${RESET}" 80
    draw_line "${CYAN}📈 Ver Alertas:${WHITE} Lista e gerencia alertas ativos${RESET}" 80
    draw_empty_line 80
    draw_line "${YELLOW}Navegação:${RESET}" 80
    draw_line "${WHITE}  ↑↓ ou números - Selecionar opção${RESET}" 80
    draw_line "${WHITE}  ENTER ou ESPAÇO - Confirmar${RESET}" 80
    draw_line "${WHITE}  ESC ou q - Voltar/Sair${RESET}" 80
    draw_empty_line 80
    draw_divider 80
    draw_empty_line 80
    draw_line "${WHITE}Pressione qualquer tecla para continuar...${RESET}" 80
    draw_empty_line 80
    draw_bottom_border 80

    read -rsn1
}

# Menu principal
main_menu() {
    local selected=0
    local total_options=6

    while true; do
        flush_input
        draw_header
        draw_menu $selected
        draw_footer

        read_key

        case "$KEY_PRESSED" in
            up)
                ((selected--))
                [ $selected -lt 0 ] && selected=$((total_options-1))
                ;;
            down)
                ((selected++))
                [ $selected -ge $total_options ] && selected=0
                ;;
            enter|space)
                flush_input
                case $selected in
                    0) show_quotes ;;
                    1) convert_currency ;;
                    2) configure_alert ;;
                    3) view_alerts ;;
                    4) show_help ;;
                    5)
                        clear_screen
                        echo -e "${GREEN}Obrigado por usar o Tio Câmbio!${RESET}"
                        exit 0
                        ;;
                esac
                ;;
            [1-6])
                flush_input
                case "$KEY_PRESSED" in
                    1) show_quotes ;;
                    2) convert_currency ;;
                    3) configure_alert ;;
                    4) view_alerts ;;
                    5) show_help ;;
                    6)
                        clear_screen
                        echo -e "${GREEN}Obrigado por usar o Tio Câmbio!${RESET}"
                        exit 0
                        ;;
                esac
                ;;
            quit|esc)
                clear_screen
                echo -e "${GREEN}Obrigado por usar o Tio Câmbio!${RESET}"
                exit 0
                ;;
        esac
    done
}

# Verificar se o script principal existe
if [ ! -f "$SCRIPT_PATH" ]; then
    echo -e "${RED}Erro: Script tiocambio.sh não encontrado!${RESET}"
    echo "Certifique-se de que tiocambio.sh está no mesmo diretório."
    exit 1
fi

# Limpar arquivos temporários antigos
trap "rm -f $TEMP_FILE" EXIT

# Iniciar menu
main_menu
