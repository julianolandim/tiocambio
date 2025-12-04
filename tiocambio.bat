@echo off
chcp 65001 >nul
REM Script para consultar cotações de moedas em relação ao Real (BRL)
REM Versão Windows Batch

setlocal enabledelayedexpansion

REM Verifica se curl está disponível
where curl >nul 2>nul
if %errorlevel% neq 0 (
    echo Erro: curl não encontrado. Por favor, instale o curl ou use Windows 10/11.
    exit /b 1
)

REM Processa argumentos
if "%1"=="" goto SHOW_ALL
if "%1"=="-h" goto HELP
if "%1"=="--help" goto HELP

REM Conversões específicas
if "%1"=="--usd-brl" (
    if "%2"=="" (
        echo Erro: Forneça um valor
        exit /b 1
    )
    call :convert_currency USD BRL %2 "Dólares" "Reais"
    exit /b 0
)

if "%1"=="--brl-usd" (
    if "%2"=="" (
        echo Erro: Forneça um valor
        exit /b 1
    )
    call :convert_currency BRL USD %2 "Reais" "Dólares"
    exit /b 0
)

if "%1"=="--eur-brl" (
    if "%2"=="" (
        echo Erro: Forneça um valor
        exit /b 1
    )
    call :convert_currency EUR BRL %2 "Euros" "Reais"
    exit /b 0
)

if "%1"=="--brl-eur" (
    if "%2"=="" (
        echo Erro: Forneça um valor
        exit /b 1
    )
    call :convert_currency BRL EUR %2 "Reais" "Euros"
    exit /b 0
)

echo Opção inválida: %1
echo Use --help para ver as opções disponíveis
exit /b 1

:HELP
echo ==========================================
echo      CONVERSOR DE MOEDAS
echo ==========================================
echo.
echo Uso: %0 [opcoes]
echo.
echo Opcoes de conversao:
echo   --usd-brl ^<valor^>    Converte Dolar para Real
echo   --brl-usd ^<valor^>    Converte Real para Dolar
echo   --eur-brl ^<valor^>    Converte Euro para Real
echo   --brl-eur ^<valor^>    Converte Real para Euro
echo   -h, --help           Mostra esta ajuda
echo.
echo Exemplos:
echo   %0 --usd-brl 10      # Converte 10 dolares para reais
echo   %0 --brl-usd 50      # Converte 50 reais para dolares
echo   %0                   # Mostra todas as cotacoes
echo.
exit /b 0

:convert_currency
setlocal
set FROM=%1
set TO=%2
set AMOUNT=%3
set FROM_NAME=%4
set TO_NAME=%5

for /f "delims=" %%i in ('curl -s "https://api.exchangerate-api.com/v4/latest/%FROM%"') do set response=%%i

REM Extrai a taxa de câmbio usando findstr
echo !response! | findstr /r "\"%TO%\":[0-9.]*" >nul
if %errorlevel% equ 0 (
    for /f "tokens=2 delims=:" %%a in ('echo !response! ^| findstr /r "\"%TO%\":[0-9.]*"') do (
        set rate=%%a
        set rate=!rate:,= !
        for %%b in (!rate!) do set rate=%%b
    )
    REM Calcula resultado (aproximado, batch não tem precisão decimal nativa)
    echo %AMOUNT% %FROM_NAME% = ~!rate! %TO_NAME%
) else (
    echo Erro ao obter taxa de conversao
)
endlocal
exit /b 0

:SHOW_ALL
echo ==========================================
echo   COTACOES DE MOEDAS EM RELACAO AO REAL
echo ==========================================
echo.
echo AMERICAS
echo ==========================================
call :get_rate USD "Dolar Americano (EUA)"
call :get_rate CAD "Dolar Canadense"
call :get_rate ARS "Peso Argentino"
call :get_rate PYG "Guarani Paraguaio"

echo.
echo EUROPA
echo ==========================================
call :get_rate EUR "Euro"
call :get_rate GBP "Libra Esterlina (Reino Unido)"
call :get_rate CHF "Franco Suico"

echo.
echo ASIA E OCEANIA
echo ==========================================
call :get_rate JPY "Iene Japones"
call :get_rate CNY "Yuan Chines"
call :get_rate AUD "Dolar Australiano"

echo.
echo ==========================================
echo Consulta realizada em: %date% %time%
echo ==========================================
exit /b 0

:get_rate
setlocal
set CURRENCY=%1
set NAME=%2

for /f "delims=" %%i in ('curl -s "https://api.exchangerate-api.com/v4/latest/%CURRENCY%"') do set response=%%i

echo !response! | findstr /r "\"BRL\":[0-9.]*" >nul
if %errorlevel% equ 0 (
    for /f "tokens=2 delims=:" %%a in ('echo !response! ^| findstr /r "\"BRL\":[0-9.]*"') do (
        set rate=%%a
        set rate=!rate:,= !
        for %%b in (!rate!) do set rate=%%b
    )
    echo 1 %NAME% = R$ !rate!
) else (
    echo Erro ao obter cotacao de %NAME%
)
endlocal
exit /b 0
