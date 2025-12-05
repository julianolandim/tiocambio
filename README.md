# 💰 Currency + Bitcoin Converter

**English** | **[Português](README-ptbr.md)**

---

Multi-platform script for real-time currency and Bitcoin exchange rate queries. Convert between 11 traditional currencies and Bitcoin (BTC).

**Available for:**
- 🐧 Linux/macOS (Bash)
- 🪟 Windows (PowerShell and Batch)
- 🖥️ Graphical Interface (GUI with Python/Tkinter)
- 🖼️ Terminal Interface (TUI - Text User Interface)

## 📋 Features

- ✅ Real-time exchange rate queries via API
- ✅ Support for 12 currencies (11 traditional + Bitcoin)
- ✅ Bidirectional currency conversion
- ✅ **Monetary formatting respecting each country's standard** 🌍
- ✅ Visual interface with emojis
- ✅ **Modern and intuitive Graphical Interface (GUI)** 🖥️
- ✅ **Interactive Terminal Interface (TUI) with navigation** 🖼️
- ✅ Organization by geographic regions
- ✅ Commercial and parallel (tourism) dollar quotation
- ✅ Real-time Bitcoin (BTC) quotation
- ✅ **Bitcoin price alert system** 🔔
- ✅ **Alert system for any currency pair** 💱
- ✅ Continuous monitoring with notifications
- ✅ No API key required

## 📁 Project Structure

```
tiocambio/
├── tiocambio.sh          # Main script (Bash) - 22KB
├── tiocambio_tui.sh      # Terminal Interface (TUI) - 20KB
├── tiocambio.ps1         # PowerShell version (Windows) - 7.7KB
├── tiocambio.bat         # Batch version (Windows) - 4KB
├── tiocambio_gui.py      # Graphical Interface (Python/Tkinter) - 15KB
├── run_gui.sh            # GUI launcher script - 1.2KB
├── requirements.txt      # Python dependencies - 376B
├── README.md             # Main documentation - 18KB
├── GUI_GUIDE.md          # Graphical Interface Guide - 5.5KB
└── CHECKLIST.md          # Project checklist - 5KB
```

## 💱 International Monetary Formatting

TioCâmbio automatically respects each country's formatting standard:

### 🇧🇷 Brazil, Argentina, Paraguay (BRL, ARS, PYG)
- **Thousands separator:** period (.)
- **Decimal separator:** comma (,)
- **Example:** `1.000,00` (one thousand reais)

### 🇺🇸 United States, Canada, United Kingdom (USD, CAD, GBP, JPY, CNY, CHF, AUD)
- **Thousands separator:** comma (,)
- **Decimal separator:** period (.)
- **Example:** `1,000.00` (one thousand dollars)

### 🇪🇺 Europe (EUR)
- **Thousands separator:** space ( )
- **Decimal separator:** comma (,)
- **Example:** `1 000,00` (one thousand euros)

### ₿ Bitcoin (BTC)
- **No separators**
- **8 decimal places** (maximum precision)
- **Example:** `0.00012345`

**Value input (TUI):**
The system accepts ANY format as input and automatically normalizes it:
- `1000` → `1.000,00` (BRL) or `1,000.00` (USD)
- `1000.50` → `1.000,50` (BRL) or `1,000.50` (USD)
- `1.000,50` → `1.000,50` (BRL)
- `1,000.50` → `1,000.50` (USD)

## 🌍 Supported Currencies

### 💵 Americas
- **USD** - US Dollar
- **USD Parallel** - Tourism/Parallel Dollar
- **CAD** - Canadian Dollar
- **BRL** - Brazilian Real
- **ARS** - Argentine Peso
- **PYG** - Paraguayan Guarani

### 💶 Europe
- **EUR** - Euro
- **GBP** - British Pound Sterling
- **CHF** - Swiss Franc

### 🌏 Asia and Oceania
- **JPY** - Japanese Yen
- **CNY** - Chinese Yuan
- **AUD** - Australian Dollar

### ₿ Cryptocurrencies
- **BTC** - Bitcoin

## 🚀 Installation

### 🖥️ Graphical Interface (GUI)

The GUI offers a modern and intuitive visual experience with all script functionalities in a user-friendly interface.

#### Prerequisites
- Python 3.6 or higher
- Tkinter (usually comes with Python)

**Check if Python is installed:**
```bash
python3 --version
```

**Check if Tkinter is available:**
```bash
python3 -c "import tkinter; print('Tkinter OK')"
```

**If Tkinter is not installed:**

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

#### How to use the GUI

**Option 1: Launch script (recommended)**
```bash
./run_gui.sh
```

**Option 2: Run directly**
```bash
python3 tiocambio_gui.py
```

#### GUI Features

📊 **Quotes Tab:**
- Select base currency
- View all quotes in real time
- Organized and easy-to-read interface

💱 **Conversion Tab:**
- Select source currency
- Enter amount to convert
- Select destination currency
- Instant result

🔔 **Alerts Tab:**
- Configure alerts for any currency pair
- Specific Bitcoin alerts
- View active alerts in real time
- Manage multiple simultaneous alerts
- Detailed logs of each check

### 🖼️ Terminal Interface (TUI)

The TUI offers a beautiful graphical interface directly in the terminal, without needing Python or external libraries!

#### How to use the TUI

```bash
./tiocambio_tui.sh
```

#### TUI Features

**Beautiful interface with ASCII characters:**
- Double borders drawn with Unicode characters
- Vibrant colors and emojis
- Navigation with arrows or numbers
- Interactive menus

**📊 View Quotes:**
- Visual base currency selection
- Formatted display of all quotes
- Navigate with arrow keys ↑↓

**💱 Conversion:**
- Visual selection of source/destination currencies
- Value input with validation
- Formatted instant result

**🔔 Configure Alerts:**
- Menu to choose type (Currency Pair or Bitcoin)
- Visual currency selection
- Configuration of min/max values
- Alerts run in background

**📈 View Active Alerts:**
- List of all running alerts
- Show PID and details of each alert
- Option to kill all alerts (key 'k')

**Navigation:**
- `↑↓` - Navigate menu
- `ENTER` or `SPACE` - Confirm selection
- `1-6` - Numeric shortcut
- `ESC` or `q` - Back/Exit

**TUI Advantages:**
- No external dependencies (Bash only!)
- Works in any terminal
- Beautiful and modern visual interface
- Intuitive navigation
- Perfect for SSH servers

### 🐧 Linux / macOS

#### Prerequisites
The script requires the following programs installed:
- `curl` - for HTTP requests
- `bc` - for mathematical calculations
- `bash` - shell (usually already installed)

On macOS, these programs usually come pre-installed. On Linux:

```bash
# Debian/Ubuntu
sudo apt-get install curl bc

# Red Hat/CentOS/Fedora
sudo yum install curl bc
```

#### Download and Setup

1. Clone the repository or download the file:
```bash
git clone https://github.com/your-user/tiocambio.git
cd tiocambio
```

2. Give execution permission to the script:
```bash
chmod +x tiocambio.sh
```

### 🪟 Windows

You have **3 options** to run on Windows:

#### Option 1: PowerShell (Recommended)

**Prerequisites:** PowerShell 5.1+ (already included in Windows 10/11)

```powershell
# 1. Download the tiocambio.ps1 file
# 2. Open PowerShell
# 3. Navigate to the file directory
cd C:\path\to\file

# 4. If necessary, enable script execution (only once):
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 5. Run the script
.\tiocambio.ps1
```

#### Option 2: Batch (.bat)

**Prerequisites:** Windows 10/11 with curl installed (included by default)

```cmd
# 1. Download the tiocambio.bat file
# 2. Open Command Prompt (CMD)
# 3. Navigate to the file directory
cd C:\path\to\file

# 4. Run the script
tiocambio.bat
```

#### Option 3: WSL (Windows Subsystem for Linux)

If you have WSL installed, you can use the Bash script normally:

```bash
# 1. Open WSL (Ubuntu, Debian, etc)
# 2. Install prerequisites
sudo apt-get install curl bc

# 3. Run the bash script
chmod +x tiocambio.sh
./tiocambio.sh
```

## 💻 Usage

⚠️ **IMPORTANT:** The script now requires you to specify a **base currency**!

### Mode 1: Run without arguments (Interactive Menu)

If you run the script without arguments, an interactive menu will be displayed for you to choose the base currency:

**Linux/macOS:**
```bash
./tiocambio.sh
```

**Example output:**
```
==========================================
💰  TIO CÂMBIO - SELECT BASE CURRENCY
==========================================

Choose the base currency to view quotes:

  1) 🇧🇷 BRL - Brazilian Real
  2) 💵 USD - US Dollar
  3) 💶 EUR - Euro
  4) 💷 GBP - British Pound
  5) 💴 JPY - Japanese Yen
  6) 🇨🇳 CNY - Chinese Yuan
  7) 🇨🇭 CHF - Swiss Franc
  8) 🇨🇦 CAD - Canadian Dollar
  9) 🇦🇺 AUD - Australian Dollar
 10) 🇦🇷 ARS - Argentine Peso
 11) 🇵🇾 PYG - Paraguayan Guarani
 12) ₿  BTC - Bitcoin
  0) ❌ Exit

Enter currency number:
```

### Mode 2: View quotes relative to a specific currency

Use the base currency flag to view all quotes relative to it:

**Linux/macOS:**
```bash
# View quotes relative to Brazilian Real
./tiocambio.sh -brl

# View quotes relative to US Dollar
./tiocambio.sh -usd

# View quotes relative to Euro
./tiocambio.sh -eur

# View quotes relative to British Pound
./tiocambio.sh -gbp
```

### Mode 3: Convert specific amounts

Now you can convert amounts using the simplified syntax:

```bash
# New syntax: -<base_currency> <destination_currency> <amount>

# Convert 100 Reais to Dollars
./tiocambio.sh -brl usd 100
# Output: 🇧🇷 100 Brazilian Real = 💵 17.39 US Dollar

# Convert 50 Dollars to Reais
./tiocambio.sh -usd brl 50
# Output: 💵 50 US Dollar = 🇧🇷 287.50 Brazilian Real

# Convert 200 Euros to Pounds
./tiocambio.sh -eur gbp 200
# Output: 💶 200 Euro = 💷 168.50 British Pound

# Convert 1000 Reais to Euros
./tiocambio.sh -brl eur 1000
# Output: 🇧🇷 1000 Brazilian Real = 💶 161.81 Euro
```

### Mode 4: Bitcoin price alerts

Monitor Bitcoin price and receive alerts when it enters a specific price range:

```bash
# Syntax: ./tiocambio.sh --btc-alert <currency> <min_value> <max_value>

# Monitor Bitcoin in Reais (alert between R$ 450k and R$ 500k)
./tiocambio.sh --btc-alert brl 450000 500000

# Monitor Bitcoin in Dollars (alert between $90k and $100k)
./tiocambio.sh --btc-alert usd 90000 100000

# Monitor Bitcoin in Euros (alert between €85k and €95k)
./tiocambio.sh --btc-alert eur 85000 95000
```

**How it works:**
- The script checks Bitcoin price every 60 seconds
- When the price is **WITHIN** the range, it emits a sound alert 🔔
- When the price is **OUTSIDE** the range, it only shows the status
- Press `Ctrl+C` to stop monitoring

### Mode 5: Alerts for any currency pair

Now you can monitor conversion between ANY currency pair, not just Bitcoin:

```bash
# Syntax: ./tiocambio.sh --alert <source_currency> <destination_currency> <min_value> <max_value>

# Monitor Dollar → Real (alert between R$ 5.00 and R$ 5.50)
./tiocambio.sh --alert usd brl 5.0 5.5

# Monitor Euro → Dollar (alert between $1.10 and $1.20)
./tiocambio.sh --alert eur usd 1.10 1.20

# Monitor Pound → Real (alert between R$ 6.50 and R$ 7.00)
./tiocambio.sh --alert gbp brl 6.5 7.0

# Monitor Bitcoin → Dollar (alert between $90k and $100k)
./tiocambio.sh --alert btc usd 90000 100000
```

**Run in background:**
```bash
# Leave monitoring running in background
nohup ./tiocambio.sh --alert usd brl 5.0 5.5 > usd_alert.log 2>&1 &

# Check the log
tail -f usd_alert.log

# Stop monitoring
pkill -f "tiocambio.sh --alert"
```

### Mode 6: View help

```bash
./tiocambio.sh --help
```

## 📖 Complete List of Supported Currencies

### Available Base Currencies

You can use any of these currencies as base:

| Flag | Currency | Emoji |
|------|----------|-------|
| `-brl` | Brazilian Real | 🇧🇷 |
| `-usd` | US Dollar | 💵 |
| `-eur` | Euro | 💶 |
| `-gbp` | British Pound | 💷 |
| `-jpy` | Japanese Yen | 💴 |
| `-cny` | Chinese Yuan | 🇨🇳 |
| `-chf` | Swiss Franc | 🇨🇭 |
| `-cad` | Canadian Dollar | 🇨🇦 |
| `-aud` | Australian Dollar | 🇦🇺 |
| `-ars` | Argentine Peso | 🇦🇷 |
| `-pyg` | Paraguayan Guarani | 🇵🇾 |
| `-btc` | Bitcoin | ₿ |

## 🔧 APIs Used

The script uses three public and free APIs:

1. **ExchangeRate-API** (https://exchangerate-api.com)
   - Official quotes for major traditional currencies
   - No registration or API key required
   - Real-time updates

2. **AwesomeAPI** (https://economia.awesomeapi.com.br)
   - Brazilian parallel/tourism dollar quotation
   - Brazilian API specialized in financial market

3. **CoinGecko API** (https://www.coingecko.com)
   - Real-time Bitcoin quotes
   - Support for multiple fiat currencies
   - Free and no API key required

## 📝 Practical Usage Examples

### Using the Terminal Interface (TUI) - RECOMMENDED!

The most practical way to use Tio Câmbio is through the TUI (Terminal User Interface):

```bash
# Start terminal interface
./tiocambio_tui.sh
```

**Why use the TUI?**
- ✨ Beautiful interface with borders and colors
- ⚡ Fast and lightweight (Bash only!)
- 🎯 Intuitive arrow navigation
- 🖥️ Works in any terminal
- 🔧 No external dependencies
- 🌐 Perfect for SSH and remote servers

**How to navigate the TUI:**
1. Use arrow keys ↑↓ to navigate
2. Press ENTER to select
3. Use numbers (1-6) as shortcuts
4. Press ESC or 'q' to exit

**How to input values in the TUI:**
When making conversions, you can type the value in any format:
- ✅ `1000` - Numbers only
- ✅ `1000.50` - American format (period decimal)
- ✅ `1.000,50` - Brazilian format (period thousands, comma decimal)
- ✅ `1,000.50` - International format (comma thousands, period decimal)
- ✅ `1 000,50` - European format (space thousands, comma decimal)

The system **automatically normalizes** any format for correct calculation!

### Using the Graphical Interface (GUI)

If you prefer a traditional graphical window:

```bash
# Start graphical interface
./run_gui.sh

# Or directly
python3 tiocambio_gui.py
```

**GUI Advantages:**
- Visual interface with windows
- Organized tabs
- Ideal for desktop
- Requires Python + Tkinter

### Calculate travel costs

```bash
# How much in reais do I need to have 1000 dollars?
./tiocambio.sh -usd brl 1000

# How much will I have in euros with 5000 reais?
./tiocambio.sh -brl eur 5000
```

### Compare international prices

```bash
# A product costs 299 dollars, how much is it in reais?
./tiocambio.sh -usd brl 299

# A product costs 199 pounds, how much is it in reais?
./tiocambio.sh -gbp brl 199
```

### Market analysis

```bash
# View all quotes relative to Real
./tiocambio.sh -brl

# View all quotes relative to Dollar
./tiocambio.sh -usd

# View all quotes relative to Euro
./tiocambio.sh -eur
```

### Compare currencies without using Real

```bash
# How much is 500 dollars worth in euros?
./tiocambio.sh -usd eur 500

# How much is 1000 pounds worth in yen?
./tiocambio.sh -gbp jpy 1000
```

### Invest in Bitcoin

```bash
# View current Bitcoin quotation in reais
./tiocambio.sh -brl

# How much does 0.01 Bitcoin cost in reais?
./tiocambio.sh -btc brl 0.01

# How many Bitcoins can I buy with 10000 reais?
./tiocambio.sh -brl btc 10000

# View all currencies relative to Bitcoin
./tiocambio.sh -btc
```

### Configure Bitcoin price alerts

```bash
# Alert when Bitcoin reaches between R$ 480k and R$ 520k
./tiocambio.sh --btc-alert brl 480000 520000

# Alert for buying opportunity (low price)
./tiocambio.sh --btc-alert usd 85000 90000

# Alert for selling (high price)
./tiocambio.sh --btc-alert brl 500000 550000

# Leave running in background for continuous monitoring
nohup ./tiocambio.sh --btc-alert brl 480000 520000 > btc_alert.log 2>&1 &
```

### Monitor specific exchange rates

```bash
# Alert when Dollar is cheap to buy
./tiocambio.sh --alert usd brl 5.0 5.3

# Alert when Euro is favorable
./tiocambio.sh --alert eur brl 6.0 6.3

# Monitor EUR/USD arbitrage opportunity
./tiocambio.sh --alert eur usd 1.15 1.18

# Monitor Guarani price for trip to Paraguay
./tiocambio.sh --alert pyg brl 0.0007 0.0008

# Multiple simultaneous alerts in background
nohup ./tiocambio.sh --alert usd brl 5.0 5.5 > usd_alert.log 2>&1 &
nohup ./tiocambio.sh --alert eur brl 6.0 6.5 > eur_alert.log 2>&1 &
nohup ./tiocambio.sh --btc-alert brl 480000 520000 > btc_alert.log 2>&1 &
```

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the project
2. Create a branch for your feature (`git checkout -b feature/NewFeature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/NewFeature`)
5. Open a Pull Request

### Contribution ideas:
- Add more cryptocurrencies (Ethereum, Litecoin, etc.)
- Add more traditional currencies
- Implement quote caching
- Add history charts in GUI
- ✅ ~~Create graphical interface (GUI)~~ (Implemented!)
- Add exchange rate variation notifications
- ✅ ~~Add price alerts for Bitcoin~~ (Implemented!)
- ✅ ~~Add alerts for any currency pair~~ (Implemented!)
- Add alerts via email or Telegram
- Allow customizing alert check interval in GUI
- Save price history to CSV file
- Add "drop/rise alert" mode (alert when price drops X% or rises Y%)
- Improve GUI with trend charts
- Add dark mode in GUI
- Create mobile version (React Native or Flutter)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details in both English and Portuguese.

## ⚠️ Disclaimer

This script provides currency quotes for informational purposes only. Exchange rates may vary and should not be used as the sole source for important financial transactions. Always consult official sources and financial institutions for actual transactions.

## 👤 Author

Developed by Juliano Landim : Company: JAL Software

## 🌟 Show your support

If this project was useful to you, consider giving it a ⭐️ on the repository!

## 💝 Support

If you're enjoying this project and it has been useful to you, consider supporting us with a donation via PIX:

**PIX Key:** `+5517999727552`

Your contribution helps keep the project active and develop new features! 🙏

## 📞 Contact

- GitHub: [@julianolandim](https://github.com/julianolandim)
- Email: ibgguaira@gmial.com
- WhatsApp: +55 17 9 9972-7552

---

**Last update:** December 2025
