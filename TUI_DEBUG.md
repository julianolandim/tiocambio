# 🐛 Debug do TUI - TioCâmbio

## Problemas Conhecidos e Soluções

### Problema 1: Setas ↑↓ não funcionam

**Sintomas:**
- Pressionar setas não move a seleção no menu
- Pode aparecer caracteres estranhos ou nada acontece

**Causas Possíveis:**
1. Terminal não envia sequência de escape correta
2. Timeout muito curto na leitura
3. Variável TERM não configurada

**Soluções:**

#### Verificar sequência de setas no seu terminal:
```bash
# Execute este comando e pressione as setas
./test_simple.sh

# Ou teste diretamente:
cat -v
# Pressione setas e veja o que aparece:
# Seta Cima: ^[[A ou ^[OA
# Seta Baixo: ^[[B ou ^[OB
# Ctrl+C para sair
```

#### Verificar variável TERM:
```bash
echo $TERM
# Deve mostrar algo como: xterm-256color, screen-256color, etc.

# Se estiver vazio, configure:
export TERM=xterm-256color
```

### Problema 2: Menu desalinhado

**Sintomas:**
- Bordas não alinham
- Texto transborda ou fica torto
- Emojis bagunçam o layout

**Causas:**
1. Códigos ANSI (cores) sendo contados no comprimento
2. Emojis ocupando espaço diferente
3. Terminal com largura diferente de 80 colunas

**Soluções:**

#### Verificar largura do terminal:
```bash
tput cols
# Deve mostrar 80 ou mais
```

#### Testar alinhamento:
```bash
./test_alignment.sh
# Deve mostrar linhas perfeitamente alinhadas
```

### Problema 3: Script trava durante consultas

**Sintomas:**
- Tela fica preta/branca ao buscar cotações
- Script não responde
- Tem que matar o processo (Ctrl+C)

**Causa:**
- Script tiocambio.sh não está acessível ou com problemas

**Soluções:**

#### Verificar se tiocambio.sh existe:
```bash
ls -lh tiocambio.sh
# Deve mostrar o arquivo

# Testar manualmente:
./tiocambio.sh -brl
```

## Como Testar Passo a Passo

### 1. Teste de Sintaxe
```bash
bash -n tiocambio_tui.sh
# Não deve mostrar erros
```

### 2. Teste de Alinhamento
```bash
./test_alignment.sh
# Verifique se as linhas estão alinhadas
```

### 3. Teste de Teclas
```bash
./test_simple.sh
# Pressione 's' para testar
# Pressione setas ↑↓←→
# Pressione 'q' para sair
```

### 4. Teste Completo da TUI
```bash
./tiocambio_tui.sh

# No menu:
# - Use setas ↑↓ para navegar
# - Use números 1-6 como atalhos
# - Pressione ENTER para selecionar
# - Pressione ESC ou 'q' para sair
```

## Configurações Recomendadas

### Para melhor experiência:

```bash
# Terminal de pelo menos 80 colunas
export COLUMNS=80

# Suporte a cores
export TERM=xterm-256color

# Se usar tmux/screen:
export TERM=screen-256color
```

### Emuladores testados:

✅ **Funcionam bem:**
- Terminal (macOS)
- iTerm2 (macOS)
- GNOME Terminal (Linux)
- Konsole (Linux)
- Windows Terminal
- WSL2 + Terminal Windows

⚠️ **Podem ter problemas:**
- Terminal muito antigo
- Emulador sem suporte a UTF-8
- SSH com configuração errada

## Código das Funções Críticas

### Detecção de Setas:
```bash
read_key() {
    local key=""
    IFS= read -rsn1 key

    if [[ "$key" == $'\x1b' ]]; then
        local seq=""
        IFS= read -rsn2 -t 0.5 seq 2>/dev/null

        case "$seq" in
            '[A'|'OA') KEY_PRESSED="up" ;;
            '[B'|'OB') KEY_PRESSED="down" ;;
            # ...
        esac
    fi
}
```

### Alinhamento de Texto:
```bash
draw_line() {
    local text="$1"
    local clean="$text"

    # Remove códigos ANSI
    while [[ "$clean" =~ $'\033'\[[0-9\;]*m ]]; do
        clean="${clean//${BASH_REMATCH[0]}/}"
    done

    local text_length=${#clean}
    # Calcula padding...
}
```

## Ajuda Adicional

Se os problemas persistirem:

1. Verifique a versão do Bash:
```bash
bash --version
# Deve ser 4.0 ou superior
```

2. Teste em outro terminal

3. Verifique permissões:
```bash
chmod +x tiocambio_tui.sh
chmod +x tiocambio.sh
```

4. Execute com debug:
```bash
bash -x tiocambio_tui.sh 2> debug.log
# Veja debug.log para erros
```
