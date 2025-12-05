# Instruções para Build do TioCambio macOS

Este guia explica como criar DMGs do TioCambio para diferentes arquiteturas de macOS.

## Pré-requisitos

1. **macOS** (para criar builds nativos)
2. **Python 3.8+**
3. **Xcode Command Line Tools**
   ```bash
   xcode-select --install
   ```

## Criando um Ícone (Opcional)

Se você tiver uma imagem PNG do logo:

```bash
./create_icon.sh logo.png
```

Isso criará `TioCambio.icns`. Se não tiver um ícone, o build usará o ícone padrão.

## Criando os DMGs

Execute em um Mac (Apple Silicon recomendado):

```bash
./build_macos.sh
```

Este script cria automaticamente dois DMGs separados:
- **arm64** (Apple Silicon M1/M2/M3/M4) → `install/mac/TioCambio-X.X.X-macOS-arm64.dmg`
- **x86_64** (Intel) → `install/mac/TioCambio-X.X.X-macOS-x86_64.dmg`

**Nota:** Se o build x86_64 falhar via cross-compilation, apenas o DMG arm64 será criado (que também funciona em Macs Intel via Rosetta 2).

## Estrutura de Arquivos Criados

Os DMGs são salvos em `install/mac/`:

```
install/mac/
└── TioCambio-X.X.X-macOS-{arch}.dmg
    ├── TioCambio.app
    │   ├── Contents/
    │   │   ├── MacOS/TioCambio (executável)
    │   │   ├── Resources/
    │   │   └── Info.plist
    └── Applications (link simbólico)
```

## Instalação do DMG

1. Abra o arquivo `.dmg`
2. Arraste `TioCambio.app` para a pasta `Applications`
3. Abra pelo Launchpad ou Finder

## Resolução de Problemas

### "TioCambio.app não pode ser aberto porque é de um desenvolvedor não identificado"

1. Vá em **Preferências do Sistema** → **Segurança e Privacidade**
2. Clique em **Abrir Mesmo Assim**

Ou pelo terminal:
```bash
xattr -cr /Applications/TioCambio.app
```

### Erro de permissões

```bash
chmod +x build_macos.sh
chmod +x create_icon.sh
```

### PyInstaller não encontrado

```bash
pip install pyinstaller
```

## Notas Importantes

- **Assinatura de Código**: Para distribuição pública, considere assinar o app com um Apple Developer ID
- **Notarização**: Apps assinados podem ser notarizados pela Apple para melhor compatibilidade
- **Rosetta 2**: Builds x86_64 funcionam em Apple Silicon via Rosetta 2, mas com performance reduzida
- **Build Nativo**: Sempre prefira builds nativos para melhor performance

## Scripts Disponíveis

- `build_macos.sh` - Cria DMGs para ambas as arquiteturas (arm64 + x86_64)
- `create_icon.sh` - Gera ícone .icns a partir de PNG (opcional)

## Verificar Arquitetura do Build

```bash
# Ver arquiteturas suportadas
lipo -info dist/TioCambio.app/Contents/MacOS/TioCambio

# Exemplo de saída:
# arm64: TioCambio (para M1+)
# x86_64: TioCambio (para Intel)
# arm64 x86_64: TioCambio (universal)
```
