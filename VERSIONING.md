# 🔢 Guia de Versionamento

## Versão Atual

A versão atual está sempre visível no topo do [README.md](README.md).

## Como Incrementar a Versão

Use o script `bump_version.sh` para atualizar a versão automaticamente:

### Tipos de Incremento

```bash
# Incrementar PATCH (1.0.0 → 1.0.1) - Padrão
./bump_version.sh
# ou
./bump_version.sh patch

# Incrementar MINOR (1.0.1 → 1.1.0)
./bump_version.sh minor

# Incrementar MAJOR (1.1.0 → 2.0.0)
./bump_version.sh major
```

### Quando Usar Cada Tipo

**PATCH (1.0.x)**
- Correções de bugs
- Pequenos ajustes
- Correções de documentação
- Refatorações internas

**MINOR (1.x.0)**
- Novas funcionalidades
- Melhorias significativas
- Novos recursos que mantêm compatibilidade

**MAJOR (x.0.0)**
- Mudanças que quebram compatibilidade
- Reescrita significativa
- Remoção de funcionalidades

## Workflow Recomendado

### Para commits normais (patch):

```bash
# 1. Fazer suas alterações
# 2. Incrementar versão
./bump_version.sh

# 3. Adicionar e commitar
git add README.md
git commit -m "chore: bump version to 1.0.1"

# 4. Commitar suas alterações
git add .
git commit -m "fix: corrige bug no script de alertas"

# 5. Criar tag da versão
git tag v1.0.1

# 6. Push com tags
git push && git push --tags
```

### Para novas funcionalidades (minor):

```bash
# 1. Suas alterações já estão prontas
./bump_version.sh minor

git add README.md
git commit -m "chore: bump version to 1.1.0"

git add .
git commit -m "feat: adiciona suporte para mais criptomoedas"

git tag v1.1.0
git push && git push --tags
```

## Formato da Versão

Seguimos o padrão **Semantic Versioning (SemVer)**:

```
MAJOR.MINOR.PATCH
  │     │     │
  │     │     └─── Correções de bugs
  │     └────────── Novas funcionalidades
  └──────────────── Mudanças incompatíveis
```

## Badge de Versão

O README.md exibe um badge com a versão atual:

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)

Este badge é atualizado automaticamente pelo script `bump_version.sh`.

## Histórico de Versões

### v1.0.0 (04/12/2025)
- ✅ Release inicial
- ✅ CLI com 12 moedas
- ✅ TUI interativa
- ✅ GUI Python/Tkinter
- ✅ Sistema de alertas completo
- ✅ Documentação profissional

## Dicas

1. **Sempre incremente antes de commitar** a feature
2. **Use tags** no git para marcar versões importantes
3. **Documente** mudanças significativas no CHANGELOG (se houver)
4. **Seja consistente** com o padrão SemVer

## Automação Futura

Possíveis melhorias:
- Git hook para incrementar automaticamente no commit
- GitHub Actions para criar releases automáticas
- Changelog automático baseado em commits
- Badge dinâmico do GitHub Releases
