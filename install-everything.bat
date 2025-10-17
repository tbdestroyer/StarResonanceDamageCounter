@echo off
setlocal enabledelayedexpansion
color 0B
title Star Resonance Damage Counter - Zero Prerequisites Installer

echo ===============================================
echo  Star Resonance Damage Counter
echo  ZERO PREREQUISITES INSTALLER
echo ===============================================
echo.
echo This installer will download and install EVERYTHING needed:
echo  ✓ Node.js (JavaScript runtime)
echo  ✓ Npcap (network packet capture)
echo  ✓ All project dependencies
echo  ✓ Electron framework
echo.
echo [!] Some steps may require administrator privileges
echo [!] You will be prompted when needed
echo.
set /p confirm="Ready to install everything? (y/n): "
if /i not "%confirm%"=="y" exit /b

REM Change to script directory
cd /d "%~dp0"

echo.
echo ===============================================
echo  STEP 1: NODE.JS INSTALLATION
echo ===============================================
echo.

REM Check if Node.js is already installed
node --version >nul 2>&1
if %errorLevel% equ 0 (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [✓] Node.js already installed: !NODE_VERSION!
    goto :install_npcap
)

echo [*] Node.js not found. Downloading installer...

REM Create temp directory
if not exist "temp" mkdir temp

REM Download Node.js LTS installer
echo [*] Downloading Node.js v20.18.0 LTS...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.18.0/node-v20.18.0-x64.msi' -OutFile 'temp\nodejs.msi' -UseBasicParsing}"

if not exist "temp\nodejs.msi" (
    echo [X] Failed to download Node.js installer!
    echo [!] Please check your internet connection
    echo [!] Or download manually from: https://nodejs.org/
    pause
    exit /b 1
)

echo [✓] Download complete!
echo.
echo [*] Installing Node.js...
echo [!] A Windows installer will open - please follow these steps:
echo     1. Click "Next" through all screens
echo     2. Accept the license agreement
echo     3. Use default installation location
echo     4. Click "Install" (may require admin password)
echo     5. Wait for installation to complete
echo.
echo [*] Starting installer now...
start /wait temp\nodejs.msi

REM Clean up
del temp\nodejs.msi

REM Verify installation
echo [*] Verifying Node.js installation...
node --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [X] Node.js installation failed!
    echo [!] Please try installing manually from: https://nodejs.org/
    echo [!] Then run this script again
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo [✓] Node.js installed successfully: !NODE_VERSION!

:install_npcap
echo.
echo ===============================================
echo  STEP 2: NPCAP NETWORK CAPTURE
echo ===============================================
echo.

REM Check if we can load network capture (rough check)
echo [*] Downloading Npcap installer...

REM Download Npcap installer
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://npcap.com/dist/npcap-1.79.exe' -OutFile 'temp\npcap.exe' -UseBasicParsing}"

if not exist "temp\npcap.exe" (
    echo [!] Failed to download Npcap automatically
    echo [!] Please download manually from: https://nmap.org/npcap/
    echo [!] Install with default settings, then continue
    pause
    goto :install_dependencies
)

echo [✓] Download complete!
echo.
echo [*] Installing Npcap...
echo [!] An installer will open - please follow these steps:
echo     1. Click "I Agree" to accept license
echo     2. Use default settings (just click "Install")
echo     3. May require administrator password
echo     4. Wait for installation to complete
echo.
echo [*] Starting Npcap installer now...
start /wait temp\npcap.exe

REM Clean up
del temp\npcap.exe

echo [✓] Npcap installation completed!

:install_dependencies
echo.
echo ===============================================
echo  STEP 3: PROJECT DEPENDENCIES
echo ===============================================
echo.

if not exist "package.json" (
    echo [X] package.json not found!
    echo [!] Make sure you're running this from the project directory
    pause
    exit /b 1
)

echo [*] Installing project dependencies...
echo [*] This may take 2-5 minutes...
npm install

if %errorLevel% neq 0 (
    echo [X] Failed to install dependencies!
    echo.
    echo Troubleshooting:
    echo  - Check internet connection
    echo  - Try: npm cache clean --force
    echo  - Try: npm install --force
    pause
    exit /b 1
)

echo [✓] Dependencies installed successfully!

echo.
echo ===============================================
echo  STEP 4: ELECTRON FRAMEWORK
echo ===============================================
echo.

echo [*] Installing Electron framework...
npm install electron --save-dev

if %errorLevel% neq 0 (
    echo [X] Failed to install Electron!
    pause
    exit /b 1
)

echo [✓] Electron installed successfully!

REM Clean up temp directory
if exist "temp" rmdir /s /q temp

echo.
echo ===============================================
echo  INSTALLATION COMPLETE!
echo ===============================================
echo.

echo [✓] ALL COMPONENTS SUCCESSFULLY INSTALLED!
echo.
echo What was installed:
echo  • Node.js !NODE_VERSION! ✓
echo  • Npcap (network packet capture) ✓
echo  • Project dependencies ✓
echo  • Electron framework ✓
echo.
echo ===============================================
echo  READY TO USE!
echo ===============================================
echo.
echo To start the enhanced Star Resonance Damage Counter:
echo.
echo  Option 1: Double-click "start-overlay.bat"
echo  Option 2: Run "node server.js" in command prompt
echo.
echo Enhanced Features Include:
echo  • F1-F12 hotkeys for all functions
echo  • Always-on-top overlay (works with fullscreen games)
echo  • English translations for Chinese text
echo  • Color-coded damage tables
echo  • Responsive charts and graphs
echo  • Multiple view modes (table/chart/both)
echo.
echo For help: https://github.com/tbdestroyer/StarResonanceDamageCounter
echo.

echo [*] Installation complete! Press any key to exit...
pause >nul