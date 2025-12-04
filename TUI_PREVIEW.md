# 🖼️ Preview da Interface de Terminal (TUI)

## Menu Principal

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║                  💰  TIO CÂMBIO - CONVERSOR DE MOEDAS  💰                    ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║                            MENU PRINCIPAL                                    ║
║                                                                              ║
║      ▶ 1. 📊 Ver Cotações                                                   ║
║        2. 💱 Converter Moedas                                                ║
║        3. 🔔 Configurar Alertas                                              ║
║        4. 📈 Ver Alertas Ativos                                              ║
║        5. ❓ Ajuda                                                           ║
║        6. ❌ Sair                                                            ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║      Use as setas ↑↓ ou números para navegar | ESC ou q para sair          ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

## Seleção de Moeda

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║                  💰  TIO CÂMBIO - CONVERSOR DE MOEDAS  💰                    ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║                      Selecione a moeda base:                                 ║
║                                                                              ║
║      ▶ 🇧🇷 BRL - Real Brasileiro                                            ║
║        💵 USD - Dólar Americano                                              ║
║        💶 EUR - Euro                                                         ║
║        💷 GBP - Libra Esterlina                                              ║
║        💴 JPY - Iene Japonês                                                 ║
║        🇨🇳 CNY - Yuan Chinês                                                 ║
║        🇨🇭 CHF - Franco Suíço                                                ║
║        🇨🇦 CAD - Dólar Canadense                                             ║
║        🇦🇺 AUD - Dólar Australiano                                           ║
║        🇦🇷 ARS - Peso Argentino                                              ║
║        🇵🇾 PYG - Guarani Paraguaio                                           ║
║        ₿  BTC - Bitcoin                                                      ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║      Use as setas ↑↓ ou números para navegar | ESC ou q para sair          ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

## Resultado de Conversão

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║                  💰  TIO CÂMBIO - CONVERSOR DE MOEDAS  💰                    ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║                        RESULTADO DA CONVERSÃO                                ║
║                                                                              ║
║         💵 100 Dólar Americano = 🇧🇷 532.00 Real Brasileiro                 ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║              Pressione qualquer tecla para continuar...                      ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

## Alertas Ativos

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║                  💰  TIO CÂMBIO - CONVERSOR DE MOEDAS  💰                    ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║                            ALERTAS ATIVOS                                    ║
║                                                                              ║
║      ✓ PID 12345: USD → BRL (5.0 - 5.5)                                     ║
║      ✓ PID 12346: EUR → BRL (6.0 - 6.5)                                     ║
║      ✓ PID 12347: BTC → BRL (480000 - 520000)                               ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║    Pressione 'k' para matar todos os alertas ou qualquer tecla para voltar  ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

## Características da TUI

### 🎨 Visual
- Bordas duplas desenhadas com caracteres Unicode (╔═╗║╚╝╠╣)
- Cores vibrantes usando códigos ANSI
- Emojis para identificação visual
- Seta verde (▶) para item selecionado
- Layout centralizado e organizado

### ⌨️ Navegação
- **↑↓** - Navegar entre opções
- **ENTER / ESPAÇO** - Confirmar seleção
- **1-6** - Atalhos numéricos diretos
- **ESC / q** - Voltar ou sair
- **k** - Matar alertas (na tela de alertas ativos)

### ⚡ Performance
- Totalmente em Bash puro
- Sem dependências externas
- Rápido e responsivo
- Baixo consumo de memória

### 🔧 Funcionalidades
1. **Ver Cotações** - Seleciona moeda base e mostra todas as cotações
2. **Converter Moedas** - Converte valores entre duas moedas
3. **Configurar Alertas** - Cria alertas de preço (par ou Bitcoin)
4. **Ver Alertas Ativos** - Lista e gerencia alertas em execução
5. **Ajuda** - Mostra instruções de uso
6. **Sair** - Encerra o programa

### 🌟 Vantagens

**Comparado com CLI puro:**
- ✅ Interface visual bonita
- ✅ Navegação intuitiva
- ✅ Não precisa lembrar comandos
- ✅ Feedback visual imediato

**Comparado com GUI:**
- ✅ Nenhuma dependência (Python, Tkinter, etc)
- ✅ Funciona via SSH
- ✅ Mais leve e rápido
- ✅ Perfeito para servidores

### 🎯 Casos de Uso Ideais

1. **Servidores remotos via SSH**
   - Interface bonita sem X11
   - Baixo consumo de banda

2. **Terminais minimalistas**
   - Usuários que preferem terminal
   - Workflow baseado em teclado

3. **Ambientes sem GUI**
   - Containers Docker
   - Servidores sem desktop

4. **Scripts e automação**
   - Pode ser usado interativamente
   - Ou chamado diretamente via CLI

---

**Experimente agora:**
```bash
./tiocambio_tui.sh
```

Navegue com as setas, selecione com ENTER, e desfrute de uma interface linda sem sair do terminal! 🚀
