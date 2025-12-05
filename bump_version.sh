#!/bin/bash

# Script para incrementar a versão no README.md
# Uso: ./bump_version.sh [major|minor|patch]
# Padrão: patch (incrementa o último número)

VERSION_TYPE=${1:-patch}

# Extrair versão atual do README.md
CURRENT_VERSION=$(grep -o 'version-[0-9]\+\.[0-9]\+\.[0-9]\+' README.md | head -1 | sed 's/version-//')

if [ -z "$CURRENT_VERSION" ]; then
    echo "❌ Erro: Não foi possível encontrar a versão no README.md"
    exit 1
fi

echo "📌 Versão atual: $CURRENT_VERSION"

# Separar os números da versão
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR="${VERSION_PARTS[0]}"
MINOR="${VERSION_PARTS[1]}"
PATCH="${VERSION_PARTS[2]}"

# Incrementar conforme o tipo
case $VERSION_TYPE in
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    patch)
        PATCH=$((PATCH + 1))
        ;;
    *)
        echo "❌ Tipo inválido: $VERSION_TYPE"
        echo "Use: major, minor ou patch"
        exit 1
        ;;
esac

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

echo "🚀 Nova versão: $NEW_VERSION"

# Atualizar README.md
sed -i.bak "s/version-${CURRENT_VERSION}/version-${NEW_VERSION}/g" README.md

# Verificar se a substituição funcionou
if grep -q "version-${NEW_VERSION}" README.md; then
    rm -f README.md.bak
    echo "✅ README.md atualizado com sucesso!"
    echo ""
    echo "📝 Próximos passos:"
    echo "   git add README.md"
    echo "   git commit -m \"chore: bump version to ${NEW_VERSION}\""
    echo "   git tag v${NEW_VERSION}"
    echo "   git push && git push --tags"
else
    # Restaurar backup se algo deu errado
    mv README.md.bak README.md
    echo "❌ Erro ao atualizar README.md"
    exit 1
fi
