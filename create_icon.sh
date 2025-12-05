#!/bin/bash
# Script para criar ícone .icns para macOS
# Requer uma imagem PNG de 1024x1024

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Verificar se imagem foi fornecida
if [ -z "$1" ]; then
    echo -e "${RED}Uso: $0 <imagem.png>${NC}"
    echo -e "${YELLOW}A imagem deve ter no mínimo 1024x1024 pixels${NC}"
    exit 1
fi

INPUT_IMAGE="$1"

if [ ! -f "$INPUT_IMAGE" ]; then
    echo -e "${RED}Arquivo não encontrado: $INPUT_IMAGE${NC}"
    exit 1
fi

echo -e "${GREEN}Criando ícone macOS (.icns)...${NC}"

# Criar diretório temporário para iconset
ICONSET="TioCambio.iconset"
rm -rf "$ICONSET"
mkdir "$ICONSET"

# Gerar todos os tamanhos necessários
sips -z 16 16     "$INPUT_IMAGE" --out "${ICONSET}/icon_16x16.png"
sips -z 32 32     "$INPUT_IMAGE" --out "${ICONSET}/icon_16x16@2x.png"
sips -z 32 32     "$INPUT_IMAGE" --out "${ICONSET}/icon_32x32.png"
sips -z 64 64     "$INPUT_IMAGE" --out "${ICONSET}/icon_32x32@2x.png"
sips -z 128 128   "$INPUT_IMAGE" --out "${ICONSET}/icon_128x128.png"
sips -z 256 256   "$INPUT_IMAGE" --out "${ICONSET}/icon_128x128@2x.png"
sips -z 256 256   "$INPUT_IMAGE" --out "${ICONSET}/icon_256x256.png"
sips -z 512 512   "$INPUT_IMAGE" --out "${ICONSET}/icon_256x256@2x.png"
sips -z 512 512   "$INPUT_IMAGE" --out "${ICONSET}/icon_512x512.png"
sips -z 1024 1024 "$INPUT_IMAGE" --out "${ICONSET}/icon_512x512@2x.png"

# Criar arquivo .icns
iconutil -c icns "$ICONSET"

# Limpar
rm -rf "$ICONSET"

echo -e "${GREEN}✓ Ícone criado: TioCambio.icns${NC}"
