#!/bin/bash

# Script de lançamento da GUI do Tio Câmbio

echo "🚀 Iniciando TIO CÂMBIO GUI..."
echo ""

# Verificar se Python está instalado
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 não está instalado!"
    echo "Por favor, instale Python 3 para usar a interface gráfica."
    exit 1
fi

# Verificar se o script bash existe
if [ ! -f "tiocambio.sh" ]; then
    echo "❌ Script tiocambio.sh não encontrado!"
    echo "Certifique-se de que está no diretório correto."
    exit 1
fi

# Verificar se o script GUI existe
if [ ! -f "tiocambio_gui.py" ]; then
    echo "❌ Script tiocambio_gui.py não encontrado!"
    exit 1
fi

# Verificar permissões
if [ ! -x "tiocambio.sh" ]; then
    echo "🔧 Ajustando permissões do tiocambio.sh..."
    chmod +x tiocambio.sh
fi

# Verificar se tkinter está disponível
python3 -c "import tkinter" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "⚠️  Tkinter não está instalado!"
    echo ""
    echo "Para instalar no macOS:"
    echo "  brew install python-tk@3.12"
    echo ""
    echo "Para instalar no Linux (Ubuntu/Debian):"
    echo "  sudo apt-get install python3-tk"
    echo ""
    exit 1
fi

# Iniciar a GUI
echo "✅ Tudo pronto! Abrindo interface gráfica..."
python3 tiocambio_gui.py
