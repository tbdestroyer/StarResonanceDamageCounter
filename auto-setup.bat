@echo off
setlocal enabledelayedexpansion
color 0E
title Star Resonance Damage Counter - Auto Setup
echo  - Node.js (via Chocolatey)
echo  - Project dependencies
echo  - Npcap for network capture
echo.
echo [!] This requires Administrator privileges
echo [!] The script will request elevation automatically
echo.
set /p confirm="Continue with automatic installation? (y/n): "
if /i not "%confirm%"=="y" goto :end

echo.
echo ===============================================
echo  CHECKING ADMINISTRATOR PRIVILEGES
echo ===============================================
echo.

REM Check if already running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Requesting administrator privileges...
    echo [*] A UAC prompt will appear - click "Yes" to continue
    
    REM Re-run this script as administrator
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
) else (
    echo [✓] Running with administrator privileges
)

echo.
echo ===============================================
echo  STEP 1: CHOCOLATEY PACKAGE MANAGER
echo ===============================================
echo.

choco --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [*] Installing Chocolatey package manager...
    powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    
    REM Refresh environment variables
    call refreshenv.cmd >nul 2>&1
    
    echo [✓] Chocolatey installed!
set CHOCO_PATH=%ProgramData%\chocolatey\bin\choco.exe
if exist "%CHOCO_PATH%" (
    set CHOCO=%CHOCO_PATH%
) else (
    set CHOCO=choco
)
echo  STEP 2: NODE.JS INSTALLATION
echo ===============================================
echo.

node --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [*] Installing Node.js via Chocolatey...
    choco install nodejs -y
    
    REM Refresh environment
    call refreshenv.cmd >nul 2>&1
    
    echo [✓] Node.js installed!
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [✓] Node.js already installed: !NODE_VERSION!
)

echo.
echo ===============================================
echo  STEP 3: NPCAP NETWORK CAPTURE
echo ===============================================
echo.

echo [*] Installing Npcap for network packet capture...
choco install npcap -y

echo.
echo ===============================================
echo  STEP 4: PROJECT DEPENDENCIES
echo ===============================================
echo.

if not exist "package.json" (
    echo [X] package.json not found!
    echo [!] Make sure you're running this from the project directory.
    pause
    goto :end
)

echo [*] Installing project dependencies...
npm install

if !errorLevel! neq 0 (
    echo [X] Failed to install dependencies!
    pause
    goto :end
)

echo [✓] All dependencies installed!

echo.
echo ===============================================
echo  STEP 5: ELECTRON FRAMEWORK
echo ===============================================
echo.

echo [*] Installing Electron...
npm install electron --save-dev

echo.
echo ===============================================
echo  SETUP COMPLETE!
echo ===============================================
echo.

echo [✓] All components have been automatically installed!
echo.
echo What was installed:
echo  • Chocolatey (Windows package manager)
echo  • Node.js (JavaScript runtime)
echo  • npm dependencies (project libraries)
echo  • Electron (overlay framework)
echo  • Npcap (network packet capture)
echo.
echo [*] IMPORTANT: Restart your computer before using the application
echo [*] After restart, use start-overlay.bat to launch the app
echo.
echo To start the application:
echo  • Double-click "start-overlay.bat" 
echo  • Or run: node server.js
echo.

:end
echo.
pause