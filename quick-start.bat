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
echo [*] The server will ask you to:
echo      1. Select network adapter (choose your main internet connection)
echo      2. Select log level (choose 'info')  
echo      3. Start overlay (choose 'y')
echo.

node server.js

echo.
echo [*] Server has stopped.
echo [*] If you want to restart, run this script again.

echo.
echo Application closed. Thanks for using the enhanced version!
pause