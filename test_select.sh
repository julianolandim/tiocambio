#!/bin/bash

source tiocambio_tui.sh

clear
echo "Teste de select_currency"
echo ""

select_currency "Teste: Selecione uma moeda"

echo ""
echo "Resultado: SELECTED_CURRENCY = '$SELECTED_CURRENCY'"
echo "Exit code: $?"
