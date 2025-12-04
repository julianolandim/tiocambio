# Script PowerShell para consultar cotações de moedas em relação ao Real (BRL)
# Versão Windows PowerShell

param(
    [Parameter(Position=0)]
    [string]$Operation,

    [Parameter(Position=1)]
    [decimal]$Value
)

# Configuração UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Função para converter moedas
function Convert-Currency {
    param(
        [string]$From,
        [string]$To,
        [decimal]$Amount,
        [string]$FromName,
        [string]$ToName,
        [string]$Emoji
    )

    try {
        $response = Invoke-RestMethod -Uri "https://api.exchangerate-api.com/v4/latest/$From" -Method Get
        $rate = $response.rates.$To

        if ($rate) {
            $result = [math]::Round($Amount * $rate, 2)
            Write-Host "$Emoji $Amount $FromName = R$ $result $ToName"
        } else {
            Write-Host "❌ Erro ao obter taxa de conversão"
        }
    } catch {
        Write-Host "❌ Erro de conexão: $_"
    }
}

# Função para obter cotação
function Get-ExchangeRate {
    param(
        [string]$Currency,
        [string]$Name,
        [string]$Emoji
    )

    try {
        $response = Invoke-RestMethod -Uri "https://api.exchangerate-api.com/v4/latest/$Currency" -Method Get
        $rate = $response.rates.BRL

        if ($rate) {
            Write-Host "$Emoji 1 $Name = R$ $rate"
        } else {
            Write-Host "❌ Erro ao obter cotação de $Name"
        }
    } catch {
        Write-Host "❌ Erro de conexão ao buscar $Name"
    }
}

# Função de ajuda
function Show-Help {
    Write-Host "=========================================="
    Write-Host "💰  CONVERSOR DE MOEDAS"
    Write-Host "=========================================="
    Write-Host ""
    Write-Host "Uso: .\moedas.ps1 [opções] [valor]"
    Write-Host ""
    Write-Host "Opções de conversão:"
    Write-Host "  -usd-brl <valor>     Converte Dólar para Real"
    Write-Host "  -brl-usd <valor>     Converte Real para Dólar"
    Write-Host "  -eur-brl <valor>     Converte Euro para Real"
    Write-Host "  -brl-eur <valor>     Converte Real para Euro"
    Write-Host "  -gbp-brl <valor>     Converte Libra para Real"
    Write-Host "  -brl-gbp <valor>     Converte Real para Libra"
    Write-Host "  -jpy-brl <valor>     Converte Iene para Real"
    Write-Host "  -brl-jpy <valor>     Converte Real para Iene"
    Write-Host "  -cny-brl <valor>     Converte Yuan para Real"
    Write-Host "  -brl-cny <valor>     Converte Real para Yuan"
    Write-Host "  -chf-brl <valor>     Converte Franco Suíço para Real"
    Write-Host "  -brl-chf <valor>     Converte Real para Franco Suíço"
    Write-Host "  -cad-brl <valor>     Converte Dólar Canadense para Real"
    Write-Host "  -brl-cad <valor>     Converte Real para Dólar Canadense"
    Write-Host "  -aud-brl <valor>     Converte Dólar Australiano para Real"
    Write-Host "  -brl-aud <valor>     Converte Real para Dólar Australiano"
    Write-Host "  -ars-brl <valor>     Converte Peso Argentino para Real"
    Write-Host "  -brl-ars <valor>     Converte Real para Peso Argentino"
    Write-Host "  -pyg-brl <valor>     Converte Guarani para Real"
    Write-Host "  -brl-pyg <valor>     Converte Real para Guarani"
    Write-Host "  -help                Mostra esta ajuda"
    Write-Host ""
    Write-Host "Exemplos:"
    Write-Host "  .\moedas.ps1 -usd-brl 10    # Converte 10 dólares para reais"
    Write-Host "  .\moedas.ps1 -brl-usd 50    # Converte 50 reais para dólares"
    Write-Host "  .\moedas.ps1                # Mostra todas as cotações"
    Write-Host ""
}

# Função para mostrar todas as cotações
function Show-AllRates {
    Write-Host "=========================================="
    Write-Host "💰  COTAÇÕES DE MOEDAS EM RELAÇÃO AO REAL"
    Write-Host "=========================================="
    Write-Host ""

    Write-Host "💵 AMÉRICAS"
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    Get-ExchangeRate "USD" "Dólar Americano (EUA)" "💵"

    # Buscar Dólar Paralelo
    try {
        $response = Invoke-RestMethod -Uri "https://economia.awesomeapi.com.br/json/last/USD-BRL" -Method Get
        $rate = $response.'USDBRL'.high
        if ($rate) {
            Write-Host "💸 1 Dólar Paralelo (Turismo) = R$ $rate"
        }
    } catch {
        # Ignora erro silenciosamente
    }

    Get-ExchangeRate "CAD" "Dólar Canadense" "🇨🇦"
    Get-ExchangeRate "ARS" "Peso Argentino" "🇦🇷"
    Get-ExchangeRate "PYG" "Guarani Paraguaio" "🇵🇾"

    Write-Host ""
    Write-Host "💶 EUROPA"
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    Get-ExchangeRate "EUR" "Euro" "💶"
    Get-ExchangeRate "GBP" "Libra Esterlina (Reino Unido)" "💷"
    Get-ExchangeRate "CHF" "Franco Suíço" "🇨🇭"

    Write-Host ""
    Write-Host "🌏 ÁSIA E OCEANIA"
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    Get-ExchangeRate "JPY" "Iene Japonês" "💴"
    Get-ExchangeRate "CNY" "Yuan Chinês" "🇨🇳"
    Get-ExchangeRate "AUD" "Dólar Australiano" "🇦🇺"

    Write-Host ""
    Write-Host "=========================================="
    Write-Host "🕐 Consulta realizada em: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
    Write-Host "=========================================="
}

# Processa argumentos
switch ($Operation) {
    "-help" { Show-Help; exit 0 }
    "--help" { Show-Help; exit 0 }
    "-h" { Show-Help; exit 0 }

    "-usd-brl" { Convert-Currency "USD" "BRL" $Value "Dólares" "Reais" "💵"; exit 0 }
    "-brl-usd" { Convert-Currency "BRL" "USD" $Value "Reais" "Dólares" "💵"; exit 0 }
    "-eur-brl" { Convert-Currency "EUR" "BRL" $Value "Euros" "Reais" "💶"; exit 0 }
    "-brl-eur" { Convert-Currency "BRL" "EUR" $Value "Reais" "Euros" "💶"; exit 0 }
    "-gbp-brl" { Convert-Currency "GBP" "BRL" $Value "Libras" "Reais" "💷"; exit 0 }
    "-brl-gbp" { Convert-Currency "BRL" "GBP" $Value "Reais" "Libras" "💷"; exit 0 }
    "-jpy-brl" { Convert-Currency "JPY" "BRL" $Value "Ienes" "Reais" "💴"; exit 0 }
    "-brl-jpy" { Convert-Currency "BRL" "JPY" $Value "Reais" "Ienes" "💴"; exit 0 }
    "-cny-brl" { Convert-Currency "CNY" "BRL" $Value "Yuans" "Reais" "🇨🇳"; exit 0 }
    "-brl-cny" { Convert-Currency "BRL" "CNY" $Value "Reais" "Yuans" "🇨🇳"; exit 0 }
    "-chf-brl" { Convert-Currency "CHF" "BRL" $Value "Francos Suíços" "Reais" "🇨🇭"; exit 0 }
    "-brl-chf" { Convert-Currency "BRL" "CHF" $Value "Reais" "Francos Suíços" "🇨🇭"; exit 0 }
    "-cad-brl" { Convert-Currency "CAD" "BRL" $Value "Dólares Canadenses" "Reais" "🇨🇦"; exit 0 }
    "-brl-cad" { Convert-Currency "BRL" "CAD" $Value "Reais" "Dólares Canadenses" "🇨🇦"; exit 0 }
    "-aud-brl" { Convert-Currency "AUD" "BRL" $Value "Dólares Australianos" "Reais" "🇦🇺"; exit 0 }
    "-brl-aud" { Convert-Currency "BRL" "AUD" $Value "Reais" "Dólares Australianos" "🇦🇺"; exit 0 }
    "-ars-brl" { Convert-Currency "ARS" "BRL" $Value "Pesos Argentinos" "Reais" "🇦🇷"; exit 0 }
    "-brl-ars" { Convert-Currency "BRL" "ARS" $Value "Reais" "Pesos Argentinos" "🇦🇷"; exit 0 }
    "-pyg-brl" { Convert-Currency "PYG" "BRL" $Value "Guaranis" "Reais" "🇵🇾"; exit 0 }
    "-brl-pyg" { Convert-Currency "BRL" "PYG" $Value "Reais" "Guaranis" "🇵🇾"; exit 0 }

    default {
        if ($Operation -and $Operation -ne "") {
            Write-Host "❌ Opção inválida: $Operation"
            Write-Host "Use -help para ver as opções disponíveis"
            exit 1
        }
        Show-AllRates
    }
}
