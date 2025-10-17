@echo off
setlocal enabledelayedexpansion
color 0A
title Star Resonance Damage Counter - Quick Start

echo ===============================================
echo  Star Resonance Damage Counter - Enhanced
echo ===============================================
echo.

REM Change to script directory
cd /d "%~dp0"

echo [*] Starting damage counter server...
start /B node server.js

echo [*] Waiting for server initialization...
timeout /t 5 /nobreak >nul

echo [*] Starting overlay window...
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
echo Application closed. Thanks for using the enhanced version!
pause