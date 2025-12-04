# 💰 Conversor de Moedas + Bitcoin

Script multiplataforma para consultar cotações de moedas e Bitcoin em tempo real. Realize conversões entre 11 moedas tradicionais e Bitcoin (BTC).

**Disponível para:**
- 🐧 Linux/macOS (Bash)
- 🪟 Windows (PowerShell e Batch)

## 📋 Características

- ✅ Consulta cotações em tempo real via API
- ✅ Suporte para 12 moedas (11 tradicionais + Bitcoin)
- ✅ Conversão bidirecional entre moedas
- ✅ Interface visual com emojis
- ✅ Organização por regiões geográficas
- ✅ Cotação do dólar comercial e paralelo (turismo)
- ✅ Cotação de Bitcoin (BTC) em tempo real
- ✅ Sem necessidade de API key

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

### Modo 4: Ver ajuda

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
- Adicionar gráficos de histórico
- Criar interface gráfica (GUI)
- Adicionar notificações de variação cambial
- Adicionar alertas de preço para Bitcoin

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## ⚠️ Aviso Legal

Este script fornece cotações de moedas apenas para fins informativos. As taxas de câmbio podem variar e não devem ser usadas como única fonte para transações financeiras importantes. Sempre consulte fontes oficiais e instituições financeiras para transações reais.

## 👤 Autor

Desenvolvido por [Seu Nome]

## 🌟 Mostre seu apoio

Se este projeto foi útil para você, considere dar uma ⭐️ no repositório!

## 📞 Contato

- GitHub: [@seu-usuario](https://github.com/seu-usuario)
- Email: seu-email@exemplo.com

---

**Última atualização:** Dezembro 2025
