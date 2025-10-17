@echo off
setlocal enabledelayedexpansion
color 0E
title Troubleshooting & Alternative Installation

echo ===============================================
echo  TROUBLESHOOTING & ALTERNATIVE INSTALLATION
echo ===============================================
echo.
echo If the main installer failed, this script provides alternatives:
echo.

:menu
echo Choose an option:
echo.
echo  1) Install Node.js only (manual download links)
echo  2) Install Npcap only (manual download links)
echo  3) Install project dependencies only (requires Node.js)
echo  4) Check what's already installed
echo  5) Clean install (remove node_modules and reinstall)
echo  6) Exit
echo.
set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" goto :nodejs_manual
if "%choice%"=="2" goto :npcap_manual
if "%choice%"=="3" goto :deps_only
if "%choice%"=="4" goto :check_status
if "%choice%"=="5" goto :clean_install
if "%choice%"=="6" exit /b
goto :menu

:nodejs_manual
echo.
echo ===============================================
echo  NODE.JS MANUAL INSTALLATION
echo ===============================================
echo.
echo Please follow these steps:
echo.
echo 1. Open your web browser
echo 2. Go to: https://nodejs.org/
echo 3. Click the "LTS" version (recommended for most users)
echo 4. Download and run the installer
echo 5. Follow the installer with default settings
echo 6. Restart your computer
echo 7. Run this troubleshooting script again
echo.
echo The LTS version is recommended because it's stable and well-tested.
echo It will also install npm (Node Package Manager) automatically.
echo.
pause
goto :menu

:npcap_manual
echo.
echo ===============================================
echo  NPCAP MANUAL INSTALLATION
echo ===============================================
echo.
echo Please follow these steps:
echo.
echo 1. Open your web browser
echo 2. Go to: https://nmap.org/npcap/
echo 3. Click "Download" for the latest version
echo 4. Run the downloaded installer
echo 5. Accept the license agreement
echo 6. Use default settings (just click through)
echo 7. Complete the installation
echo.
echo Npcap is required for network packet capture.
echo It allows the damage counter to monitor game network traffic.
echo.
pause
goto :menu

:deps_only
echo.
echo ===============================================
echo  PROJECT DEPENDENCIES ONLY
echo ===============================================
echo.

REM Check Node.js first
node --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] Node.js not found!
    echo [!] Please install Node.js first (option 1)
    pause
    goto :menu
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo [✓] Node.js found: !NODE_VERSION!

REM Check for package.json
if not exist "package.json" (
    echo [X] package.json not found!
    echo [!] Make sure you're in the project directory
    pause
    goto :menu
)

echo [*] Installing project dependencies...
npm install

if %errorLevel% neq 0 (
    echo [X] Installation failed!
    echo.
    echo Try these solutions:
    echo  - Check internet connection
    echo  - Run option 5 (Clean install)
    echo  - Run: npm cache clean --force
    pause
    goto :menu
)

echo [*] Installing Electron...
npm install electron --save-dev

echo [✓] Dependencies installed successfully!
pause
goto :menu

:check_status
echo.
echo ===============================================
echo  CHECKING INSTALLATION STATUS
echo ===============================================
echo.

echo Checking Node.js...
node --version >nul 2>&1
if %errorLevel% equ 0 (
    for /f "tokens=*" %%i in ('node --version') do echo [✓] Node.js: !NODE_VERSION!
) else (
    echo [X] Node.js: NOT INSTALLED
)

echo Checking npm...
npm --version >nul 2>&1
if %errorLevel% equ 0 (
    for /f "tokens=*" %%i in ('npm --version') do echo [✓] npm: !NPM_VERSION!
) else (
    echo [X] npm: NOT INSTALLED
)

echo Checking project dependencies...
if exist "node_modules" (
    echo [✓] node_modules: EXISTS
) else (
    echo [X] node_modules: NOT FOUND
)

echo Checking Electron...
npx electron --version >nul 2>&1
if %errorLevel% equ 0 (
    for /f "tokens=*" %%i in ('npx electron --version') do echo [✓] Electron: !ELECTRON_VERSION!
) else (
    echo [X] Electron: NOT INSTALLED
)

echo Checking package.json...
if exist "package.json" (
    echo [✓] package.json: EXISTS
) else (
    echo [X] package.json: NOT FOUND
)

echo.
pause
goto :menu

:clean_install
echo.
echo ===============================================
echo  CLEAN INSTALLATION
echo ===============================================
echo.

if exist "node_modules" (
    echo [*] Removing old node_modules...
    rmdir /s /q node_modules
    echo [✓] Old dependencies removed
)

if exist "package-lock.json" (
    echo [*] Removing package-lock.json...
    del package-lock.json
    echo [✓] Lock file removed
)

echo [*] Clearing npm cache...
npm cache clean --force

echo [*] Installing fresh dependencies...
npm install

if %errorLevel% neq 0 (
    echo [X] Clean installation failed!
    pause
    goto :menu
)

echo [*] Installing Electron...
npm install electron --save-dev

echo [✓] Clean installation completed!
pause
goto :menu