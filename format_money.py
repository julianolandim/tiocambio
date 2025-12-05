#!/usr/bin/env python3
"""
Script para formatar valores monetários de acordo com o padrão de cada país.
Uso: format_money.py <valor> <moeda>
"""
import sys
import locale

def format_currency(value, currency):
    """
    Formata valor monetário seguindo o padrão de cada país/moeda.

    Args:
        value: Valor numérico (string ou float)
        currency: Código da moeda (USD, BRL, EUR, etc.)

    Returns:
        String formatada com separadores corretos
    """
    # Converter para float
    try:
        value = float(value)
    except ValueError:
        return "0,00"

    # Bitcoin: 8 casas decimais, sem separadores
    if currency.upper() == "BTC":
        return f"{value:.8f}"

    # Definir padrão de formatação por moeda
    if currency.upper() in ["BRL", "ARS", "PYG"]:
        # Padrão brasileiro: 1.234.567,89
        thousand_sep = "."
        decimal_sep = ","
    elif currency.upper() == "EUR":
        # Padrão europeu: 1 234 567,89
        thousand_sep = " "
        decimal_sep = ","
    else:
        # Padrão americano/internacional: 1,234,567.89
        thousand_sep = ","
        decimal_sep = "."

    # Se o valor for muito pequeno (< 0.01), usar mais casas decimais
    if abs(value) < 0.01 and value != 0:
        # Usar até 6 casas decimais para valores pequenos
        formatted = f"{value:.6f}"
    else:
        # Formatar com 2 casas decimais normalmente
        formatted = f"{value:.2f}"

    # Separar parte inteira e decimal
    parts = formatted.split(".")
    integer_part = parts[0]
    decimal_part = parts[1] if len(parts) > 1 else "00"

    # Adicionar separadores de milhares
    result = ""
    for i, digit in enumerate(reversed(integer_part)):
        if i > 0 and i % 3 == 0:
            result = thousand_sep + result
        result = digit + result

    # Retornar com separador decimal apropriado
    return f"{result}{decimal_sep}{decimal_part}"

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: format_money.py <valor> <moeda>", file=sys.stderr)
        sys.exit(1)

    value = sys.argv[1]
    currency = sys.argv[2]

    print(format_currency(value, currency))
