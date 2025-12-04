# 🖥️ Guia da Interface Gráfica - TIO CÂMBIO

## Índice
1. [Instalação](#instalação)
2. [Como Usar](#como-usar)
3. [Funcionalidades](#funcionalidades)
4. [Solução de Problemas](#solução-de-problemas)

---

## 📦 Instalação

### Pré-requisitos

Você precisa ter instalado:
- Python 3.6 ou superior
- Tkinter (biblioteca gráfica do Python)

### Verificar instalação

```bash
# Verificar Python
python3 --version

# Verificar Tkinter
python3 -c "import tkinter; print('✅ Tkinter instalado!')"
```

### Instalar Tkinter (se necessário)

**macOS:**
```bash
brew install python-tk@3.12
```

**Ubuntu/Debian:**
```bash
sudo apt-get install python3-tk
```

**Fedora/Red Hat:**
```bash
sudo dnf install python3-tkinter
```

---

## 🚀 Como Usar

### Iniciar a GUI

**Método 1: Script de lançamento (recomendado)**
```bash
./run_gui.sh
```

**Método 2: Python direto**
```bash
python3 tiocambio_gui.py
```

---

## 📱 Funcionalidades

### 📊 Aba 1: Cotações

Visualize cotações em tempo real de todas as moedas.

**Como usar:**
1. Selecione a moeda base no menu dropdown
2. Clique em "🔄 Buscar Cotações"
3. Aguarde alguns segundos
4. Veja todas as cotações organizadas por região

**Exemplo:**
- Selecione "BRL" para ver quanto custam as outras moedas em Reais
- Selecione "USD" para ver quanto custam as outras moedas em Dólares

---

### 💱 Aba 2: Conversão

Converta valores entre qualquer par de moedas.

**Como usar:**
1. Selecione a moeda DE (origem)
2. Digite o valor que deseja converter
3. Selecione a moeda PARA (destino)
4. Clique em "🔄 Converter"
5. Veja o resultado instantaneamente

**Exemplos:**
- Converter 100 Reais para Dólares
- Converter 50 Dólares para Euros
- Converter 0.01 Bitcoin para Reais

---

### 🔔 Aba 3: Alertas

Configure alertas de preço para qualquer moeda ou Bitcoin.

#### Alerta de Par de Moedas

Receba notificação quando a taxa de câmbio entrar em uma faixa específica.

**Como usar:**
1. Selecione "Par de Moedas"
2. Escolha moeda DE e PARA
3. Digite o valor mínimo
4. Digite o valor máximo
5. Clique em "▶️ Iniciar Alerta"

**Exemplo prático:**
- **Objetivo:** Ser alertado quando o Dólar estiver entre R$ 5.00 e R$ 5.30
- **Configuração:**
  - De: USD
  - Para: BRL
  - Mínimo: 5.0
  - Máximo: 5.3

#### Alerta de Bitcoin

Monitore o preço do Bitcoin em qualquer moeda.

**Como usar:**
1. Selecione "Bitcoin"
2. Escolha a moeda para monitorar (ex: BRL, USD)
3. Digite o valor mínimo
4. Digite o valor máximo
5. Clique em "▶️ Iniciar Alerta"

**Exemplo prático:**
- **Objetivo:** Ser alertado quando Bitcoin atingir entre R$ 480k e R$ 520k
- **Configuração:**
  - Para: BRL
  - Mínimo: 480000
  - Máximo: 520000

#### Gerenciar Alertas

- **Ver alertas ativos:** Todos os alertas rodando aparecem na área de texto
- **Logs em tempo real:** Cada verificação é mostrada com timestamp
- **Parar alertas:** Clique em "⏹️ Parar Todos os Alertas"

#### Múltiplos Alertas

Você pode rodar vários alertas ao mesmo tempo:
- Um para USD → BRL
- Um para EUR → BRL
- Um para Bitcoin em USD
- Etc.

---

## 🔧 Solução de Problemas

### Erro: "tkinter não encontrado"

**Solução:**
Instale o tkinter usando seu gerenciador de pacotes:
```bash
# macOS
brew install python-tk@3.12

# Ubuntu/Debian
sudo apt-get install python3-tk

# Fedora
sudo dnf install python3-tkinter
```

### Erro: "tiocambio.sh não encontrado"

**Solução:**
Certifique-se de que os arquivos estão no mesmo diretório:
- `tiocambio.sh`
- `tiocambio_gui.py`
- `run_gui.sh`

### Erro: "Permission denied"

**Solução:**
Dê permissão de execução aos scripts:
```bash
chmod +x tiocambio.sh
chmod +x run_gui.sh
chmod +x tiocambio_gui.py
```

### GUI não abre

**Verificação 1:** Python está instalado?
```bash
python3 --version
```

**Verificação 2:** Tkinter está disponível?
```bash
python3 -c "import tkinter"
```

**Verificação 3:** Script está executável?
```bash
ls -l tiocambio_gui.py
# Deve mostrar -rwxr-xr-x
```

### Cotações não aparecem

**Possíveis causas:**
1. Sem conexão com a internet
2. APIs temporariamente indisponíveis
3. Script bash sem permissão de execução

**Solução:**
```bash
# Testar conexão com API
curl -s "https://api.exchangerate-api.com/v4/latest/USD"

# Dar permissão ao script
chmod +x tiocambio.sh

# Testar script diretamente
./tiocambio.sh -brl
```

### Alertas não funcionam

**Verificar:**
1. Os valores mínimo e máximo estão corretos?
2. O valor mínimo é menor que o máximo?
3. Há conexão com a internet?

---

## 💡 Dicas de Uso

### Dica 1: Usar em background
Deixe a GUI aberta em segundo plano para monitorar alertas continuamente.

### Dica 2: Múltiplos alertas
Configure vários alertas para diferentes moedas e seja notificado de oportunidades.

### Dica 3: Atalhos
- `Cmd+Q` (macOS) ou `Alt+F4` (Linux/Windows) para fechar
- Use Tab para navegar entre campos

### Dica 4: Valores decimais
Use ponto (.) como separador decimal, não vírgula:
- ✅ Correto: 5.5
- ❌ Errado: 5,5

---

## 🎨 Recursos da Interface

- **Design limpo:** Interface moderna e organizada
- **Abas intuitivas:** Cada funcionalidade em sua própria aba
- **Emojis visuais:** Bandeiras e símbolos para fácil identificação
- **Logs em tempo real:** Veja os alertas acontecendo ao vivo
- **Responsiva:** Ajuste o tamanho da janela conforme necessário

---

## 📞 Precisa de Ajuda?

Se encontrar problemas:

1. Consulte este guia
2. Leia o [README.md](README.md) principal
3. Teste o script bash diretamente: `./tiocambio.sh -brl`
4. Abra uma issue no GitHub

---

**Última atualização:** Dezembro 2025
