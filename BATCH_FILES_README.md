# Windows Batch Files Guide

This directory contains batch files to help with setup and running the application on Windows.

## Files

### `setup.bat` - First Time Setup
Run this **FIRST** if you're setting up the application for the first time.

**What it does:**
- Checks if Node.js is installed
- Installs npm dependencies
- Sets up Electron framework
- Checks network capture requirements (Npcap/WinPcap)
- Provides detailed instructions for missing components

**Usage:**
```cmd
setup.bat
```

### `start-overlay.bat` - Enhanced Quick Start
Run this to start the application with all enhancements.

**What it does:**
- Verifies all dependencies are installed
- Auto-installs missing components when possible
- Starts the damage counter server
- Launches the enhanced overlay with F1-F12 hotkeys
- Shows hotkey guide and helpful information

**Usage:**
```cmd
start-overlay.bat
```

## Recommended First-Time Setup Process

1. **First Run**: Execute `setup.bat`
   - Follow all instructions
   - Install Node.js if needed from https://nodejs.org/
   - Install Npcap from https://nmap.org/npcap/
   - Restart computer after installations

2. **Daily Use**: Execute `start-overlay.bat`
   - Quick startup with dependency verification
   - Enhanced overlay with gaming hotkeys

## Troubleshooting

### "Node.js not found"
- Download from https://nodejs.org/
- Install the LTS (Long Term Support) version
- Restart computer after installation

### "Failed to install dependencies"
- Check internet connection
- Try running as Administrator
- Run: `npm cache clean --force`
- Try: `npm install --force`

### "Network capture failed"
- Install Npcap: https://nmap.org/npcap/
- Install with default settings
- Restart computer after installation
- May need to run application as Administrator

### Permission Issues
- Right-click the .bat file
- Select "Run as Administrator"
- This may be needed for first-time setup

## Enhanced Features

The enhanced version includes:
- **F1-F12 Hotkeys** for all major functions
- **English Translations** for Chinese game assets
- **Always-on-top overlay** compatible with fullscreen games
- **View toggles** (table/chart/both)
- **Color-coded tables** matching chart colors
- **Smart defaults** (hide inactive, simple mode)
- **Responsive design** optimized for gaming

## Support

- Enhanced Version: https://github.com/tbdestroyer/StarResonanceDamageCounter
- Original Project: https://github.com/dmlgzs/StarResonanceDamageCounter