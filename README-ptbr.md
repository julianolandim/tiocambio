# 💰 Conversor de Moedas + Bitcoin

**[English](README.md)** | **Português** | 📜 [Licença](LICENSE)

---

Script multiplataforma para consultar cotações de moedas e Bitcoin em tempo real. Realize conversões entre 11 moedas tradicionais e Bitcoin (BTC).

**Disponível para:**
- 🐧 Linux/macOS (Bash)
- 🪟 Windows (PowerShell e Batch)
- 🖥️ Interface Gráfica (GUI com Python/Tkinter)
- 🖼️ Interface de Terminal (TUI - Text User Interface)

## 📋 Características

- ✅ Consulta cotações em tempo real via API
- ✅ Suporte para 12 moedas (11 tradicionais + Bitcoin)
- ✅ Conversão bidirecional entre moedas
- ✅ **Formatação monetária respeitando padrão de cada país** 🌍
- ✅ Interface visual com emojis
- ✅ **Interface Gráfica (GUI) moderna e intuitiva** 🖥️
- ✅ **Interface de Terminal (TUI) interativa com navegação** 🖼️
- ✅ Organização por regiões geográficas
- ✅ Cotação do dólar comercial e paralelo (turismo)
- ✅ Cotação de Bitcoin (BTC) em tempo real
- ✅ **Sistema de alertas de preço para Bitcoin** 🔔
- ✅ **Sistema de alertas para qualquer par de moedas** 💱
- ✅ Monitoramento contínuo com notificações
- ✅ Sem necessidade de API key

## 📁 Estrutura do Projeto

```
tiocambio/
├── tiocambio.sh          # Script principal (Bash) - 22KB
├── tiocambio_tui.sh      # Interface de Terminal (TUI) - 20KB
├── tiocambio.ps1         # Versão PowerShell (Windows) - 7.7KB
├── tiocambio.bat         # Versão Batch (Windows) - 4KB
├── tiocambio_gui.py      # Interface Gráfica (Python/Tkinter) - 15KB
├── run_gui.sh            # Script de lançamento da GUI - 1.2KB
├── requirements.txt      # Dependências Python - 376B
├── README.md             # Documentação principal - 18KB
├── GUI_GUIDE.md          # Guia da Interface Gráfica - 5.5KB
└── CHECKLIST.md          # Checklist do projeto - 5KB
```

## 💱 Formatação Monetária Internacional

O TioCâmbio respeita automaticamente o padrão de formatação de cada país:

### 🇧🇷 Brasil, Argentina, Paraguai (BRL, ARS, PYG)
- **Separador de milhares:** ponto (.)
- **Separador decimal:** vírgula (,)
- **Exemplo:** `1.000,00` (mil reais)

### 🇺🇸 Estados Unidos, Canadá, Reino Unido (USD, CAD, GBP, JPY, CNY, CHF, AUD)
- **Separador de milhares:** vírgula (,)
- **Separador decimal:** ponto (.)
- **Exemplo:** `1,000.00` (mil dólares)

### 🇪🇺 Europa (EUR)
- **Separador de milhares:** espaço ( )
- **Separador decimal:** vírgula (,)
- **Exemplo:** `1 000,00` (mil euros)

### ₿ Bitcoin (BTC)
- **Sem separadores**
- **8 casas decimais** (precisão máxima)
- **Exemplo:** `0.00012345`

**Entrada de valores (TUI):**
O sistema aceita QUALQUER formato na entrada e normaliza automaticamente:
- `1000` → `1.000,00` (BRL) ou `1,000.00` (USD)
- `1000.50` → `1.000,50` (BRL) ou `1,000.50` (USD)
- `1.000,50` → `1.000,50` (BRL)
- `1,000.50` → `1,000.50` (USD)

## 🌍 Moedas Suportadas

### 💵 Américas
- **USD** - Dólar Americano (EUA)
- **USD Paralelo** - Dólar Turismo/Paralelo
- **CAD** - Dólar Canadense
- **ARS** - Peso Argentino
- **PYG** - Guarani Paraguaio

### 💶 Europa
- **EUR** - Euro
- **GBP** - Libra Esterlina (Reino Unido)
- **CHF** - Franco Suíço

### 🌏 Ásia e Oceania
- **JPY** - Iene Japonês
- **CNY** - Yuan Chinês
- **AUD** - Dólar Australiano

### ₿ Criptomoedas
- **BTC** - Bitcoin

## 🚀 Instalação

### 🖥️ Interface Gráfica (GUI)

A GUI oferece uma experiência visual moderna e intuitiva com todas as funcionalidades do script em uma interface amigável.

#### Pré-requisitos
- Python 3.6 ou superior
- Tkinter (geralmente já vem com Python)

**Verificar se o Python está instalado:**
```bash
python3 --version
```

**Verificar se o Tkinter está disponível:**
```bash
python3 -c "import tkinter; print('Tkinter OK')"
```

**Se o Tkinter não estiver instalado:**

macOS:
```bash
brew install python-tk@3.12
```

Linux (Ubuntu/Debian):
```bash
sudo apt-get install python3-tk
```

Linux (Fedora/Red Hat):
```bash
sudo dnf install python3-tkinter
```

#### Como usar a GUI

**Opção 1: Script de lançamento (recomendado)**
```bash
./run_gui.sh
```

**Opção 2: Executar diretamente**
```bash
python3 tiocambio_gui.py
```

#### Funcionalidades da GUI

📊 **Aba Cotações:**
- Selecione a moeda base
- Visualize todas as cotações em tempo real
- Interface organizada e fácil de ler

💱 **Aba Conversão:**
- Selecione moeda de origem
- Digite o valor a converter
- Selecione moeda de destino
- Resultado instantâneo

🔔 **Aba Alertas:**
- Configure alertas para qualquer par de moedas
- Alertas específicos para Bitcoin
- Visualize alertas ativos em tempo real
- Gerencie múltiplos alertas simultâneos
- Logs detalhados de cada verificação

### 🖼️ Interface de Terminal (TUI)

A TUI oferece uma interface gráfica linda diretamente no terminal, sem precisar de Python ou bibliotecas externas!

#### Como usar a TUI

```bash
./tiocambio_tui.sh
```

#### Funcionalidades da TUI

**Interface bonita com caracteres ASCII:**
- Bordas duplas desenhadas com caracteres Unicode
- Cores vibrantes e emojis
- Navegação por setas ou números
- Menus interativos

**📊 Ver Cotações:**
- Seleção visual de moeda base
- Exibição formatada de todas as cotações
- Navegação por setas ↑↓

**💱 Conversão:**
- Seleção visual de moedas origem/destino
- Input de valor com validação
- Resultado instantâneo formatado

**🔔 Configurar Alertas:**
- Menu para escolher tipo (Par de Moedas ou Bitcoin)
- Seleção visual de moedas
- Configuração de valores mín/máx
- Alertas executados em background

**📈 Ver Alertas Ativos:**
- Lista de todos os alertas rodando
- Mostrar PID e detalhes de cada alerta
- Opção para matar todos os alertas (tecla 'k')

**Navegação:**
- `↑↓` - Navegar pelo menu
- `ENTER` ou `ESPAÇO` - Confirmar seleção
- `1-6` - Atalho numérico
- `ESC` ou `q` - Voltar/Sair

**Vantagens da TUI:**
- Nenhuma dependência externa (só Bash!)
- Funciona em qualquer terminal
- Interface visual linda e moderna
- Navegação intuitiva
- Perfeita para servidores SSH

### 🐧 Linux / macOS

#### Pré-requisitos
O script requer os seguintes programas instalados:
- `curl` - para fazer requisições HTTP
- `bc` - para cálculos matemáticos
- `bash` - shell (geralmente já instalado)

No macOS, estes programas geralmente já vêm instalados. No Linux:

```bash
# Debian/Ubuntu
sudo apt-get install curl bc

# Red Hat/CentOS/Fedora
sudo yum install curl bc
```

#### Download e Configuração

1. Clone o repositório ou baixe o arquivo:
```bash
git clone https://github.com/seu-usuario/tiocambio.git
cd tiocambio
```

2. Dê permissão de execução ao script:
```bash
chmod +x tiocambio.sh
```

### 🪟 Windows

Você tem **3 opções** para executar no Windows:

#### Opção 1: PowerShell (Recomendado)

**Pré-requisitos:** PowerShell 5.1+ (já incluído no Windows 10/11)

```powershell
# 1. Baixe o arquivo tiocambio.ps1
# 2. Abra o PowerShell
# 3. Navegue até o diretório do arquivo
cd C:\caminho\para\o\arquivo

# 4. Se necessário, habilite a execução de scripts (uma vez apenas):
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 5. Execute o script
.\tiocambio.ps1
```

#### Opção 2: Batch (.bat)

**Pré-requisitos:** Windows 10/11 com curl instalado (já incluído por padrão)

```cmd
# 1. Baixe o arquivo tiocambio.bat
# 2. Abra o Prompt de Comando (CMD)
# 3. Navegue até o diretório do arquivo
cd C:\caminho\para\o\arquivo

# 4. Execute o script
tiocambio.bat
```

#### Opção 3: WSL (Windows Subsystem for Linux)

Se você tem WSL instalado, pode usar o script Bash normalmente:

```bash
# 1. Abra o WSL (Ubuntu, Debian, etc)
# 2. Instale os pré-requisitos
sudo apt-get install curl bc

# 3. Execute o script bash
chmod +x tiocambio.sh
./tiocambio.sh
```

## 💻 Uso

⚠️ **IMPORTANTE:** O script agora requer que você especifique uma **moeda base** obrigatória!

### Modo 1: Executar sem argumentos (Menu Interativo)

Se você executar o script sem argumentos, um menu interativo será exibido para você escolher a moeda base:

**Linux/macOS:**
```bash
./tiocambio.sh
```

**Exemplo de saída:**
```
==========================================
💰  TIO CÂMBIO - SELECIONE A MOEDA BASE
==========================================

Escolha a moeda base para ver as cotações:

  1) 🇧🇷 BRL - Real Brasileiro
  2) 💵 USD - Dólar Americano
  3) 💶 EUR - Euro
  4) 💷 GBP - Libra Esterlina
  5) 💴 JPY - Iene Japonês
  6) 🇨🇳 CNY - Yuan Chinês
  7) 🇨🇭 CHF - Franco Suíço
  8) 🇨🇦 CAD - Dólar Canadense
  9) 🇦🇺 AUD - Dólar Australiano
 10) 🇦🇷 ARS - Peso Argentino
 11) 🇵🇾 PYG - Guarani Paraguaio
 12) ₿  BTC - Bitcoin
  0) ❌ Sair

Digite o número da moeda:
```

### Modo 2: Ver cotações em relação a uma moeda específica

Use a flag da moeda base para ver todas as cotações em relação a ela:

**Linux/macOS:**
```bash
# Ver cotações em relação ao Real Brasileiro
./tiocambio.sh -brl

# Ver cotações em relação ao Dólar Americano
./tiocambio.sh -usd

# Ver cotações em relação ao Euro
./tiocambio.sh -eur

# Ver cotações em relação à Libra Esterlina
./tiocambio.sh -gbp
```

**Exemplo com `-brl` (quanto custam as moedas em Real):**
```
==========================================
🇧🇷  QUANTO CUSTAM AS MOEDAS EM Real Brasileiro
==========================================

💵 AMÉRICAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💵 1 Dólar Americano (EUA) = 5.32 Real Brasileiro
💸 1 Dólar Paralelo (Turismo) = 5.32 Real Brasileiro
🇨🇦 1 Dólar Canadense = 3.81 Real Brasileiro
🇦🇷 1 Peso Argentino = 0.0037 Real Brasileiro
🇵🇾 1 Guarani Paraguaio = 0.00076 Real Brasileiro

💶 EUROPA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💶 1 Euro = 6.20 Real Brasileiro
💷 1 Libra Esterlina (Reino Unido) = 7.08 Real Brasileiro
🇨🇭 1 Franco Suíço = 6.64 Real Brasileiro

🌏 ÁSIA E OCEANIA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💴 1 Iene Japonês = 0.034 Real Brasileiro
🇨🇳 1 Yuan Chinês = 0.75 Real Brasileiro
🇦🇺 1 Dólar Australiano = 3.51 Real Brasileiro

₿ CRIPTOMOEDAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
₿ 1 Bitcoin = 491532 Real Brasileiro
```

**Exemplo com `-usd` (quanto custam as moedas em Dólar):**
```
==========================================
💵  QUANTO CUSTAM AS MOEDAS EM Dólar Americano
==========================================

💰 PRINCIPAIS MOEDAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🇧🇷 1 Real Brasileiro = 0.19 Dólar Americano
💶 1 Euro = 1.17 Dólar Americano
💷 1 Libra Esterlina = 1.33 Dólar Americano
💴 1 Iene Japonês = 0.0064 Dólar Americano
🇨🇳 1 Yuan Chinês = 0.14 Dólar Americano
...
```

### Modo 3: Converter valores específicos

Agora você pode converter valores usando a sintaxe simplificada:

```bash
# Nova sintaxe: -<moeda_base> <moeda_destino> <valor>

# Converter 100 Reais para Dólares
./tiocambio.sh -brl usd 100
# Saída: 🇧🇷 100 Real Brasileiro = 💵 17.39 Dólar Americano

# Converter 50 Dólares para Reais
./tiocambio.sh -usd brl 50
# Saída: 💵 50 Dólar Americano = 🇧🇷 287.50 Real Brasileiro

# Converter 200 Euros para Libras
./tiocambio.sh -eur gbp 200
# Saída: 💶 200 Euro = 💷 168.50 Libra Esterlina

# Converter 1000 Reais para Euros
./tiocambio.sh -brl eur 1000
# Saída: 🇧🇷 1000 Real Brasileiro = 💶 161.81 Euro
```

### Modo 4: Alertas de preço do Bitcoin

Monitore o preço do Bitcoin e receba alertas quando ele entrar em uma faixa de preço específica:

```bash
# Sintaxe: ./tiocambio.sh --btc-alert <moeda> <valor_min> <valor_max>

# Monitorar Bitcoin em Reais (alerta entre R$ 450k e R$ 500k)
./tiocambio.sh --btc-alert brl 450000 500000

# Monitorar Bitcoin em Dólares (alerta entre $90k e $100k)
./tiocambio.sh --btc-alert usd 90000 100000

# Monitorar Bitcoin em Euros (alerta entre €85k e €95k)
./tiocambio.sh --btc-alert eur 85000 95000
```

**Como funciona:**
- O script verifica o preço do Bitcoin a cada 60 segundos
- Quando o preço está **DENTRO** da faixa, emite um alerta sonoro 🔔
- Quando o preço está **FORA** da faixa, mostra apenas o status
- Pressione `Ctrl+C` para parar o monitoramento

**Exemplo de saída:**
```
==========================================
₿  ALERTA DE PREÇO DO BITCOIN
==========================================

Moeda: 🇧🇷 Real Brasileiro
Faixa de alerta: 450000 - 500000
Intervalo de verificação: 60s

Pressione Ctrl+C para parar o monitoramento
==========================================

⏱️  [04/12/2025 14:30:15] Bitcoin: 🇧🇷 488357 Real Brasileiro (ABAIXO da faixa)
⏱️  [04/12/2025 14:31:15] Bitcoin: 🇧🇷 492150 Real Brasileiro (DENTRO DA FAIXA) 🔔
```

### Modo 5: Alertas para qualquer par de moedas

Agora você pode monitorar a conversão entre QUALQUER par de moedas, não apenas Bitcoin:

```bash
# Sintaxe: ./tiocambio.sh --alert <moeda_origem> <moeda_destino> <valor_min> <valor_max>

# Monitorar Dólar → Real (alerta entre R$ 5.00 e R$ 5.50)
./tiocambio.sh --alert usd brl 5.0 5.5

# Monitorar Euro → Dólar (alerta entre $1.10 e $1.20)
./tiocambio.sh --alert eur usd 1.10 1.20

# Monitorar Libra → Real (alerta entre R$ 6.50 e R$ 7.00)
./tiocambio.sh --alert gbp brl 6.5 7.0

# Monitorar Bitcoin → Dólar (alerta entre $90k e $100k)
./tiocambio.sh --alert btc usd 90000 100000
```

**Como funciona:**
- O script verifica a taxa de conversão a cada 60 segundos
- Quando a taxa está **DENTRO** da faixa, emite um alerta sonoro 🔔
- Quando a taxa está **FORA** da faixa, mostra apenas o status
- Pressione `Ctrl+C` para parar o monitoramento
- Funciona com TODAS as 12 moedas suportadas (incluindo Bitcoin)

**Exemplo de saída:**
```
==========================================
💱  ALERTA DE CONVERSÃO DE MOEDAS
==========================================

Conversão: 💵 Dólar Americano → 🇧🇷 Real Brasileiro
Faixa de alerta: 5.0 - 5.5
Intervalo de verificação: 60s

Pressione Ctrl+C para parar o monitoramento
==========================================

🔔 [04/12/2025 16:20:21] ALERTA! 1 💵 USD = 🇧🇷 5.32 BRL (DENTRO DA FAIXA)
⏱️  [04/12/2025 16:21:21] 1 💵 USD = 🇧🇷 5.33 BRL (DENTRO DA FAIXA)
```

**Executar em background:**
```bash
# Deixe o monitoramento rodando em background
nohup ./tiocambio.sh --alert usd brl 5.0 5.5 > usd_alert.log 2>&1 &

# Verificar o log
tail -f usd_alert.log

# Parar o monitoramento
pkill -f "tiocambio.sh --alert"
```

### Modo 6: Ver ajuda

```bash
./tiocambio.sh --help
```

## 📖 Lista Completa de Moedas Suportadas

### Moedas Base Disponíveis

Você pode usar qualquer uma destas moedas como base:

| Flag | Moeda | Emoji |
|------|-------|-------|
| `-brl` | Real Brasileiro | 🇧🇷 |
| `-usd` | Dólar Americano | 💵 |
| `-eur` | Euro | 💶 |
| `-gbp` | Libra Esterlina | 💷 |
| `-jpy` | Iene Japonês | 💴 |
| `-cny` | Yuan Chinês | 🇨🇳 |
| `-chf` | Franco Suíço | 🇨🇭 |
| `-cad` | Dólar Canadense | 🇨🇦 |
| `-aud` | Dólar Australiano | 🇦🇺 |
| `-ars` | Peso Argentino | 🇦🇷 |
| `-pyg` | Guarani Paraguaio | 🇵🇾 |
| `-btc` | Bitcoin | ₿ |

### Como Usar as Moedas

**Formato de conversão:**
```bash
./tiocambio.sh -<moeda_origem> <moeda_destino> <valor>
```

**Exemplos:**
```bash
# Real para qualquer moeda
./tiocambio.sh -brl usd 100    # BRL → USD
./tiocambio.sh -brl eur 100    # BRL → EUR
./tiocambio.sh -brl gbp 100    # BRL → GBP

# Dólar para qualquer moeda
./tiocambio.sh -usd brl 100    # USD → BRL
./tiocambio.sh -usd eur 100    # USD → EUR
./tiocambio.sh -usd jpy 100    # USD → JPY

# Entre moedas estrangeiras
./tiocambio.sh -eur gbp 100    # EUR → GBP
./tiocambio.sh -gbp jpy 100    # GBP → JPY
./tiocambio.sh -cad aud 100    # CAD → AUD

# Conversões com Bitcoin
./tiocambio.sh -btc brl 0.01   # BTC → BRL
./tiocambio.sh -brl btc 5000   # BRL → BTC
./tiocambio.sh -usd btc 1000   # USD → BTC
```

## 🔧 APIs Utilizadas

O script utiliza três APIs públicas e gratuitas:

1. **ExchangeRate-API** (https://exchangerate-api.com)
   - Cotações oficiais das principais moedas tradicionais
   - Sem necessidade de registro ou API key
   - Atualização em tempo real

2. **AwesomeAPI** (https://economia.awesomeapi.com.br)
   - Cotação do dólar paralelo/turismo brasileiro
   - API brasileira especializada em mercado financeiro

3. **CoinGecko API** (https://www.coingecko.com)
   - Cotações de Bitcoin em tempo real
   - Suporte a múltiplas moedas fiat
   - Gratuita e sem necessidade de API key

## 📝 Exemplos de Uso Prático

### Usando a Interface de Terminal (TUI) - RECOMENDADO!

A forma mais prática de usar o Tio Câmbio é através da TUI (Terminal User Interface):

```bash
# Iniciar a interface de terminal
./tiocambio_tui.sh
```

**Por que usar a TUI?**
- ✨ Interface linda com bordas e cores
- ⚡ Rápida e leve (só Bash!)
- 🎯 Navegação intuitiva com setas
- 🖥️ Funciona em qualquer terminal
- 🔧 Nenhuma dependência externa
- 🌐 Perfeita para SSH e servidores remotos

**Como navegar na TUI:**
1. Use as setas ↑↓ para navegar
2. Pressione ENTER para selecionar
3. Use números (1-6) como atalhos
4. Pressione ESC ou 'q' para sair

**Como informar valores na TUI:**
Ao fazer conversões, você pode digitar o valor em qualquer formato:
- ✅ `1000` - Apenas números
- ✅ `1000.50` - Formato americano (ponto decimal)
- ✅ `1.000,50` - Formato brasileiro (ponto milhares, vírgula decimal)
- ✅ `1,000.50` - Formato internacional (vírgula milhares, ponto decimal)
- ✅ `1 000,50` - Formato europeu (espaço milhares, vírgula decimal)

O sistema **normaliza automaticamente** qualquer formato para o cálculo correto!

### Usando a Interface Gráfica (GUI)

Se preferir uma janela gráfica tradicional:

```bash
# Iniciar a interface gráfica
./run_gui.sh

# Ou diretamente
python3 tiocambio_gui.py
```

**Vantagens da GUI:**
- Interface visual com janelas
- Tabs organizadas
- Ideal para desktop
- Requer Python + Tkinter

### Calcular custo de viagem

```bash
# Quanto preciso em reais para ter 1000 dólares?
./tiocambio.sh -usd brl 1000

# Quanto vou ter em euros com 5000 reais?
./tiocambio.sh -brl eur 5000
```

### Comparar preços internacionais

```bash
# Um produto custa 299 dólares, quanto é em reais?
./tiocambio.sh -usd brl 299

# Um produto custa 199 libras, quanto é em reais?
./tiocambio.sh -gbp brl 199
```

### Análise de mercado

```bash
# Ver todas as cotações em relação ao Real
./tiocambio.sh -brl

# Ver todas as cotações em relação ao Dólar
./tiocambio.sh -usd

# Ver todas as cotações em relação ao Euro
./tiocambio.sh -eur
```

### Comparar moedas sem usar Real

```bash
# Quanto vale 500 dólares em euros?
./tiocambio.sh -usd eur 500

# Quanto vale 1000 libras em ienes?
./tiocambio.sh -gbp jpy 1000
```

### Investir em Bitcoin

```bash
# Ver cotação atual do Bitcoin em reais
./tiocambio.sh -brl

# Quanto custa 0.01 Bitcoin em reais?
./tiocambio.sh -btc brl 0.01

# Quantos Bitcoins posso comprar com 10000 reais?
./tiocambio.sh -brl btc 10000

# Ver todas as moedas em relação ao Bitcoin
./tiocambio.sh -btc
```

### Configurar alertas de preço do Bitcoin

```bash
# Alerta quando Bitcoin atingir entre R$ 480k e R$ 520k
./tiocambio.sh --btc-alert brl 480000 520000

# Alerta para oportunidade de compra (preço baixo)
./tiocambio.sh --btc-alert usd 85000 90000

# Alerta para venda (preço alto)
./tiocambio.sh --btc-alert brl 500000 550000

# Deixe rodando em background para monitoramento contínuo
nohup ./tiocambio.sh --btc-alert brl 480000 520000 > btc_alert.log 2>&1 &
```

### Monitorar taxas de câmbio específicas

```bash
# Alerta quando o Dólar estiver barato para comprar
./tiocambio.sh --alert usd brl 5.0 5.3

# Alerta quando o Euro estiver favorável
./tiocambio.sh --alert eur brl 6.0 6.3

# Monitorar oportunidade de arbitragem EUR/USD
./tiocambio.sh --alert eur usd 1.15 1.18

# Monitorar preço do Guarani para viagem ao Paraguai
./tiocambio.sh --alert pyg brl 0.0007 0.0008

# Múltiplos alertas simultâneos em background
nohup ./tiocambio.sh --alert usd brl 5.0 5.5 > usd_alert.log 2>&1 &
nohup ./tiocambio.sh --alert eur brl 6.0 6.5 > eur_alert.log 2>&1 &
nohup ./tiocambio.sh --btc-alert brl 480000 520000 > btc_alert.log 2>&1 &
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer um Fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/NovaFuncionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/NovaFuncionalidade`)
5. Abrir um Pull Request

### Ideias para contribuição:
- Adicionar mais criptomoedas (Ethereum, Litecoin, etc.)
- Adicionar mais moedas tradicionais
- Implementar cache de cotações
- Adicionar gráficos de histórico na GUI
- ✅ ~~Criar interface gráfica (GUI)~~ (Implementado!)
- Adicionar notificações de variação cambial
- ✅ ~~Adicionar alertas de preço para Bitcoin~~ (Implementado!)
- ✅ ~~Adicionar alertas para qualquer par de moedas~~ (Implementado!)
- Adicionar alertas via email ou Telegram
- Permitir customizar intervalo de verificação dos alertas na GUI
- Salvar histórico de preços em arquivo CSV
- Adicionar modo "alerta de queda/subida" (alerta quando preço cair X% ou subir Y%)
- Melhorar a GUI com gráficos de tendência
- Adicionar modo escuro (dark mode) na GUI
- Criar versão mobile (React Native ou Flutter)

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes em inglês e português.

## ⚠️ Aviso Legal

Este script fornece cotações de moedas apenas para fins informativos. As taxas de câmbio podem variar e não devem ser usadas como única fonte para transações financeiras importantes. Sempre consulte fontes oficiais e instituições financeiras para transações reais.

## 👤 Autor

Desenvolvido por Juliano Landim : Empresa: JAL Software

## 🌟 Mostre seu apoio

Se este projeto foi útil para você, considere dar uma ⭐️ no repositório!

## 💝 Apoie

Se você está gostando deste projeto e ele tem sido útil para você, considere nos apoiar com uma doação via PIX:

**Chave PIX:** `+5517999727552`

Sua contribuição ajuda a manter o projeto ativo e a desenvolver novas funcionalidades! 🙏

## 📞 Contato

- GitHub: [@julianolandim](https://github.com/julianolandim)
- Email: ibgguaira@gmial.com
- WhatsApp: +55 17 9 9972-7552

---

**Última atualização:** Dezembro 2025
