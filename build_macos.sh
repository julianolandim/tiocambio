#!/bin/bash
# Script para criar DMG Universal do TioCambio (arm64 + x86_64)
# Executa em um Mac Apple Silicon para gerar ambas as arquiteturas

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  TioCambio - Build Universal para macOS${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Verificar se está em Apple Silicon
ARCH=$(uname -m)
if [ "$ARCH" != "arm64" ]; then
    echo -e "${YELLOW}AVISO: Este script funciona melhor em Apple Silicon${NC}"
    echo -e "${YELLOW}Continuando com build para $ARCH apenas...${NC}"
fi

# Verificar Python
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python3 não encontrado!${NC}"
    exit 1
fi

echo -e "${GREEN}Verificando dependências...${NC}"

# Guardar diretório de trabalho
WORK_DIR=$(pwd)

# Criar diretórios temporários
BUILD_ARM64="build_arm64"
BUILD_X86_64="build_x86_64"
rm -rf "$BUILD_ARM64" "$BUILD_X86_64"
mkdir -p "$BUILD_ARM64" "$BUILD_X86_64"

# Criar ambiente virtual para arm64
echo -e "${YELLOW}Criando ambiente virtual para arm64...${NC}"
python3 -m venv venv_arm64
source venv_arm64/bin/activate
pip install --upgrade pip > /dev/null
pip install -r requirements.txt > /dev/null
pip install pyinstaller > /dev/null

# Verificar se ícone existe
ICON_PARAM=""
if [ -f "icon.icns" ] || [ -f "TioCambio.icns" ]; then
    if [ -f "TioCambio.icns" ]; then
        ICON_PARAM="--icon=TioCambio.icns"
        echo -e "${GREEN}Usando ícone: TioCambio.icns${NC}"
    else
        ICON_PARAM="--icon=icon.icns"
        echo -e "${GREEN}Usando ícone: icon.icns${NC}"
    fi
else
    echo -e "${YELLOW}Nenhum ícone encontrado, usando ícone padrão${NC}"
fi

# Build para arm64
echo -e "${YELLOW}Criando build para arm64 (Apple Silicon)...${NC}"
pyinstaller --clean --noconfirm \
    --name="TioCambio" \
    --windowed \
    --onefile \
    --target-arch=arm64 \
    $ICON_PARAM \
    --add-data "${WORK_DIR}/version.py:." \
    --add-data "${WORK_DIR}/currency_api.py:." \
    --distpath="$BUILD_ARM64/dist" \
    --workpath="$BUILD_ARM64/build" \
    --specpath="$BUILD_ARM64" \
    tiocambio_gui.py

deactivate
echo -e "${GREEN}✓ Build arm64 concluído${NC}"

# Criar ambiente virtual para x86_64
echo -e "${YELLOW}Criando ambiente virtual para x86_64...${NC}"
ARCHFLAGS="-arch x86_64" python3 -m venv venv_x86_64
source venv_x86_64/bin/activate

# Tentar instalar dependências para x86_64
echo -e "${YELLOW}Instalando dependências para x86_64...${NC}"
ARCHFLAGS="-arch x86_64" pip install --upgrade pip > /dev/null
ARCHFLAGS="-arch x86_64" pip install -r requirements.txt > /dev/null 2>&1 || {
    echo -e "${YELLOW}AVISO: Algumas dependências podem não ter binários x86_64${NC}"
}
ARCHFLAGS="-arch x86_64" pip install pyinstaller > /dev/null

# Build para x86_64
echo -e "${YELLOW}Criando build para x86_64 (Intel)...${NC}"
arch -x86_64 pyinstaller --clean --noconfirm \
    --name="TioCambio" \
    --windowed \
    --onefile \
    --target-arch=x86_64 \
    $ICON_PARAM \
    --add-data "${WORK_DIR}/version.py:." \
    --add-data "${WORK_DIR}/currency_api.py:." \
    --distpath="$BUILD_X86_64/dist" \
    --workpath="$BUILD_X86_64/build" \
    --specpath="$BUILD_X86_64" \
    tiocambio_gui.py 2>&1 || {
    echo -e "${YELLOW}Build x86_64 falhou. Isso é normal em alguns casos.${NC}"
    echo -e "${YELLOW}Criando apenas versão arm64 que funciona via Rosetta 2${NC}"
    BUILD_X86_64_FAILED=true
}

deactivate
if [ "$BUILD_X86_64_FAILED" != "true" ]; then
    echo -e "${GREEN}✓ Build x86_64 concluído${NC}"
fi

# Criar diretório de destino
OUTPUT_DIR="install/mac"
mkdir -p "$OUTPUT_DIR"

# Obter versão
VERSION=$(python3 -c "from version import __version__; print(__version__)" 2>/dev/null || echo "1.0.0")

# Função para criar DMG
create_dmg() {
    local APP_PATH=$1
    local ARCH_SUFFIX=$2
    local ARCH_NAME=$3

    echo -e "${YELLOW}Criando DMG para ${ARCH_NAME}...${NC}"

    DMG_DIR="dmg_temp_${ARCH_SUFFIX}"
    rm -rf "$DMG_DIR"
    mkdir -p "$DMG_DIR"

    # Copiar app
    cp -r "$APP_PATH" "$DMG_DIR/"

    # Criar link para Applications
    ln -s /Applications "$DMG_DIR/Applications"

    # Nome e caminho do DMG
    DMG_NAME="TioCambio-${VERSION}-macOS-${ARCH_SUFFIX}.dmg"
    DMG_PATH="$OUTPUT_DIR/$DMG_NAME"

    # Criar DMG
    hdiutil create -volname "TioCambio" \
        -srcfolder "$DMG_DIR" \
        -ov -format UDZO \
        "$DMG_PATH"

    # Limpar
    rm -rf "$DMG_DIR"

    echo -e "${GREEN}✓ DMG criado: $DMG_PATH${NC}"
}

# Criar DMG para arm64
if [ -f "$BUILD_ARM64/dist/TioCambio.app/Contents/MacOS/TioCambio" ]; then
    create_dmg "$BUILD_ARM64/dist/TioCambio.app" "arm64" "Apple Silicon (M1+)"
fi

# Criar DMG para x86_64 se o build teve sucesso
if [ "$BUILD_X86_64_FAILED" != "true" ] && [ -f "$BUILD_X86_64/dist/TioCambio.app/Contents/MacOS/TioCambio" ]; then
    create_dmg "$BUILD_X86_64/dist/TioCambio.app" "x86_64" "Intel"
fi

# Limpar arquivos temporários
echo -e "${YELLOW}Limpando arquivos temporários...${NC}"
rm -rf "$BUILD_ARM64" "$BUILD_X86_64"
rm -rf venv_arm64 venv_x86_64 build dist *.spec

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ Build concluído com sucesso!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}DMGs criados em: $OUTPUT_DIR/${NC}"
ls -lh "$OUTPUT_DIR"/*.dmg 2>/dev/null | awk '{print "  - " $9 " (" $5 ")"}'
echo ""
