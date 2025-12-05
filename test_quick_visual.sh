#!/bin/bash

source tiocambio_tui.sh

clear
draw_top_border 80
draw_line "Teste de Alinhamento" 80
draw_line "${BOLD}${YELLOW}💰 TIO CÂMBIO 💰${RESET}" 80
draw_line "${GREEN}▶ ${WHITE}${BOLD}1. Ver Cotações${RESET}" 80
draw_line "${CYAN}2. Converter Moedas${RESET}" 80
draw_bottom_border 80

echo ""
echo "As bordas estão alinhadas?"
