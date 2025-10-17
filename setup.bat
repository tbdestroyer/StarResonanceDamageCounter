@echo off
setlocal enabledelayedexpansion
color 0E
title Star Resonance Damage Counter - First Time Setup

echo ===============================================
echo  Star Resonance Damage Counter
echo  FIRST TIME SETUP & REQUIREMENTS CHECK
echo ===============================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Some installations may require administrator privileges.
    echo [!] If any step fails, try running as administrator.
    echo.
)

echo This script will check and install all required components:
echo  - Node.js (JavaScript runtime)
echo  - npm packages (dependencies)
echo  - Electron (overlay framework)  
echo  - Network capture requirements
echo.
set /p confirm="Continue with setup? (y/n): "
if /i not "%confirm%"=="y" goto :end

echo.
echo ===============================================
echo  STEP 1: NODE.JS CHECK
echo ===============================================
echo.

node --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] Node.js not installed!
    echo.
    echo REQUIRED: Node.js v18+ is required for this application.
    echo.
    echo Please follow these steps:
    echo  1. Go to https://nodejs.org/
    echo  2. Download the LTS version (recommended)
    echo  3. Run the installer with default settings
    echo  4. Restart your computer
    echo  5. Run this setup script again
    echo.
    echo The installer will also install npm (Node Package Manager) automatically.
    pause
    goto :end
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [✓] Node.js is installed: !NODE_VERSION!
)

echo.
echo ===============================================
echo  STEP 2: NPM CHECK
echo ===============================================
echo.

npm --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] npm not found!
    echo [!] This usually means Node.js installation is incomplete.
    echo [!] Please reinstall Node.js from https://nodejs.org/
    pause
    goto :end
) else (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
    echo [✓] npm is available: !NPM_VERSION!
)

echo.
echo ===============================================
echo  STEP 3: PROJECT DEPENDENCIES
echo ===============================================
echo.

if not exist "package.json" (
    echo [X] package.json not found!
    echo [!] Make sure you're running this from the project directory.
    pause
    goto :end
)

if not exist "node_modules" (
    echo [*] Installing project dependencies...
    echo [*] This may take 2-5 minutes depending on your internet connection...
    echo.
    npm install
    if !errorLevel! neq 0 (
        echo.
        echo [X] Failed to install dependencies!
        echo.
        echo Common solutions:
        echo  - Check your internet connection
        echo  - Try: npm install --force
        echo  - Try: npm cache clean --force && npm install
        echo  - Run as administrator
        pause
        goto :end
    )
    echo [✓] Dependencies installed successfully!
) else (
    echo [✓] Dependencies already installed
)

echo.
echo ===============================================
echo  STEP 4: ELECTRON FRAMEWORK
echo ===============================================
echo.

npx electron --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [*] Installing Electron (overlay framework)...
    npm install electron --save-dev
    if !errorLevel! neq 0 (
        echo [X] Failed to install Electron!
        pause
        goto :end
    )
    echo [✓] Electron installed successfully!
) else (
    for /f "tokens=*" %%i in ('npx electron --version') do set ELECTRON_VERSION=%%i
    echo [✓] Electron is ready: !ELECTRON_VERSION!
)

echo.
echo ===============================================
echo  STEP 5: NETWORK CAPTURE REQUIREMENTS
echo ===============================================
echo.

echo [*] Checking network capture capabilities...
echo.

REM Try to load the cap module
node -e "try { require('cap'); console.log('Network capture: READY'); } catch(e) { console.log('Network capture: NEEDS SETUP'); process.exit(1); }" >nul 2>&1

if %errorLevel% neq 0 (
    echo [!] Network packet capture needs additional setup:
    echo.
    echo REQUIRED: Npcap or WinPcap must be installed
    echo.
    echo Please install ONE of these:
    echo  1. Npcap (RECOMMENDED): https://nmap.org/npcap/
    echo     - More modern and actively maintained
    echo     - Better Windows 10/11 compatibility
    echo     - Download and install with default settings
    echo.
    echo  2. WinPcap (Legacy): https://www.winpcap.org/
    echo     - Older but still functional
    echo     - May have issues on newer Windows versions
    echo.
    echo After installation, restart your computer and try running the app.
    echo.
) else (
    echo [✓] Network capture is ready!
)

echo.
echo ===============================================
echo  SETUP COMPLETE!
echo ===============================================
echo.

echo All requirements have been checked and installed!
echo.
echo To start the application:
echo  • Double-click "start-overlay.bat" 
echo  • Or run: node server.js
echo.
echo For help and updates:
echo  • GitHub: https://github.com/tbdestroyer/StarResonanceDamageCounter
echo  • Original: https://github.com/dmlgzs/StarResonanceDamageCounter
echo.

:end
echo.
pause