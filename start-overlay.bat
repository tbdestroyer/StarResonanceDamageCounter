@echo off
setlocal enabledelayedexpansion
color 0A
title Star Resonance Damage Counter - Enhanced Setup

echo ===============================================
echo  Star Resonance Damage Counter - Enhanced
echo ===============================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Administrative privileges may be required for some installations.
    echo [!] If installation fails, try running as administrator.
    echo.
)

echo [1/6] Checking Node.js installation...
node --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] Node.js not found! 
    echo [!] Please install Node.js from: https://nodejs.org/
    echo [!] Download the LTS version and restart this script.
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [✓] Node.js found: !NODE_VERSION!
)

echo.
echo [2/6] Checking npm/package manager...
npm --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] npm not found! Node.js installation may be incomplete.
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
    echo [✓] npm found: !NPM_VERSION!
)

echo.
echo [3/6] Checking project dependencies...
if not exist "node_modules" (
    echo [!] Dependencies not installed. Installing now...
    echo [*] This may take a few minutes...
    npm install
    if !errorLevel! neq 0 (
        echo [X] Failed to install dependencies!
        echo [!] Try running: npm install --force
        pause
        exit /b 1
    )
    echo [✓] Dependencies installed successfully!
) else (
    echo [✓] Dependencies already installed
)

echo.
echo [4/6] Checking Electron...
npx electron --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Electron not found. Installing...
    npm install electron --save-dev
    if !errorLevel! neq 0 (
        echo [X] Failed to install Electron!
        pause
        exit /b 1
    )
    echo [✓] Electron installed!
) else (
    for /f "tokens=*" %%i in ('npx electron --version') do set ELECTRON_VERSION=%%i
    echo [✓] Electron found: !ELECTRON_VERSION!
)

echo.
echo [5/6] Checking network capture capabilities...
echo [*] Note: Npcap/WinPcap is required for packet capture
echo [*] If the application fails to start, install from: https://nmap.org/npcap/

echo.
echo [6/6] Starting applications...
echo ===============================================
echo.

REM Start the main server in the background
echo [*] Starting damage counter server...
start /B node server.js

REM Wait a moment for the server to initialize
echo [*] Waiting for server initialization...
timeout /t 5 /nobreak >nul

REM Start the overlay
echo [*] Starting overlay window...
echo [*] Use F1-F12 hotkeys to control the overlay!
echo.
echo Hotkey Guide:
echo   F1 = Toggle View Mode    F7 = Toggle Damage Group
echo   F2 = Toggle Visibility   F8 = Toggle Healing Group  
echo   F3 = Clear Data         F9 = Toggle All Data
echo   F4 = Pause/Resume       F10 = Hide Inactive Users
echo   F5 = Export Data        F11 = Table Settings
echo   F6 = Copy Window URL    F12 = Open Dev Tools
echo.

npx electron overlay-launcher.js

echo.
echo ===============================================
echo Application closed. Thanks for using the enhanced version!
echo Report issues at: https://github.com/tbdestroyer/StarResonanceDamageCounter
echo ===============================================
pause

echo.
echo Server stopped.
pause