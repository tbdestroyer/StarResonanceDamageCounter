@echo off
setlocal enabledelayedexpansion
color 0A
title Star Resonance Damage Counter - Manual Setup

echo ===============================================
echo  Star Resonance Damage Counter  
echo  MANUAL SETUP (No Admin Required)
echo ===============================================
echo.

REM Change to script directory
cd /d "%~dp0"

echo Since you already have Chocolatey and Node.js installed,
echo let's just install the project dependencies directly!
echo.

echo ===============================================
echo  CHECKING REQUIREMENTS
echo ===============================================
echo.

echo [1/4] Checking Node.js...
node --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] Node.js not found! Please install from: https://nodejs.org/
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [✓] Node.js found: !NODE_VERSION!
)

echo.
echo [2/4] Checking npm...
npm --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] npm not found!
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
    echo [✓] npm found: !NPM_VERSION!
)

echo.
echo [3/4] Checking project files...
if not exist "package.json" (
    echo [X] package.json not found in: %~dp0
    echo [!] Make sure you're running this from the project directory
    pause
    exit /b 1
) else (
    echo [✓] package.json found
)

echo.
echo [4/4] Installing project dependencies...
echo [*] This may take a few minutes...
npm install

if %errorLevel% neq 0 (
    echo.
    echo [X] Failed to install dependencies!
    echo.
    echo Try these solutions:
    echo  - Check internet connection
    echo  - Run: npm cache clean --force
    echo  - Run: npm install --force
    pause
    exit /b 1
)

echo [✓] Dependencies installed successfully!

echo.
echo ===============================================
echo  INSTALLING ELECTRON
echo ===============================================
echo.

echo [*] Installing Electron framework...
npm install electron --save-dev

if %errorLevel% neq 0 (
    echo [X] Failed to install Electron
    pause
    exit /b 1
)

echo [✓] Electron installed!

echo.
echo ===============================================
echo  SETUP COMPLETE!
echo ===============================================
echo.

echo [✓] All project components are now installed!
echo.
echo What's ready:
echo  • Node.js v!NODE_VERSION! ✓
echo  • npm v!NPM_VERSION! ✓  
echo  • Project dependencies ✓
echo  • Electron framework ✓
echo.
echo [!] NOTE: You still need Npcap for network capture
echo [!] Download from: https://nmap.org/npcap/
echo [!] Install with default settings
echo.
echo To start the application:
echo  • Double-click "start-overlay.bat"
echo  • Or run: node server.js
echo.

pause