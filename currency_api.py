#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Módulo para buscar cotações de moedas via API
"""

import urllib.request
import json
from typing import Dict, Optional

API_URL = "https://api.exchangerate-api.com/v4/latest/{}"

def get_rates(base_currency: str = "USD") -> Optional[Dict]:
    """
    Busca as taxas de câmbio para uma moeda base

    Args:
        base_currency: Código da moeda base (ex: USD, BRL, EUR)

    Returns:
        Dicionário com as taxas de câmbio ou None em caso de erro
    """
    try:
        url = API_URL.format(base_currency.upper())
        with urllib.request.urlopen(url, timeout=10) as response:
            data = json.loads(response.read().decode())
            return data.get('rates', {})
    except Exception as e:
        print(f"Erro ao buscar cotações: {e}")
        return None

def convert(amount: float, from_currency: str, to_currency: str) -> Optional[float]:
    """
    Converte um valor de uma moeda para outra

    Args:
        amount: Valor a converter
        from_currency: Moeda de origem
        to_currency: Moeda de destino

    Returns:
        Valor convertido ou None em caso de erro
    """
    rates = get_rates(from_currency)
    if rates and to_currency.upper() in rates:
        return amount * rates[to_currency.upper()]
    return None
