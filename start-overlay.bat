@echo off
title Star Resonance Damage Counter
echo ================================================
echo  Star Resonance Damage Counter
echo ================================================
echo.
echo Starting damage counter server...
echo You will be prompted to:
echo  1. Select network adapter
echo  2. Select log level (info/debug)
echo  3. Choose whether to start overlay (y/n)
echo.
echo If you choose overlay, hotkeys will be:
echo   F9  - Toggle overlay visibility
echo   F10 - Toggle mouse interaction
echo   F12 - Toggle overlay opacity
echo.

node server.js

echo.
echo Server stopped.
pause