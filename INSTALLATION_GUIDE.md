# 🚀 Zero Prerequisites Installation Guide

This installation system is designed for users with **NO software installed**. Everything will be downloaded and installed automatically.

## 🎯 Quick Start (Recommended)

**For users with nothing installed:**

1. **Download this project** (extract the ZIP file)
2. **Double-click:** `install-everything.bat`
3. **Follow the prompts** (click "Yes" when Windows asks for permissions)
4. **Wait for completion** (takes 5-10 minutes)
5. **Launch:** Double-click `start-overlay.bat`

That's it! ✅

## 📁 Installation Files

### `install-everything.bat` - Main Installer
**Use this first!** Downloads and installs everything automatically:
- ✅ Node.js v20.18.0 LTS (JavaScript runtime)
- ✅ Npcap (network packet capture for game monitoring)
- ✅ All project dependencies (libraries and modules)
- ✅ Electron framework (for the overlay window)

### `troubleshoot.bat` - Problem Solver
Use this if the main installer fails:
- 🔧 Manual installation guides with direct links
- 🔍 Status checker (shows what's installed/missing)
- 🧹 Clean installation (removes old files and reinstalls)
- 🆘 Step-by-step troubleshooting for common issues

## 🎮 After Installation

### Starting the Application
- **Easy way:** Double-click `start-overlay.bat`
- **Command line:** `node server.js`

### Features You'll Get
- 🎯 **Always-on-top overlay** (works with fullscreen games)
- ⌨️ **F1-F12 hotkeys** for all major functions
- 🌐 **English translations** for Chinese game assets
- 🎨 **Color-coded tables** matching chart line colors
- 📊 **Responsive charts** with crisp rendering
- 👁️ **Multiple view modes** (table/chart/both)
- ⚙️ **Smart defaults** (hide inactive players, simple mode)

## 🛠️ Manual Installation (If Automatic Fails)

### Step 1: Install Node.js
1. Go to **https://nodejs.org/**
2. Download the **LTS version** (recommended)
3. Run installer with default settings
4. Restart your computer

### Step 2: Install Npcap
1. Go to **https://nmap.org/npcap/**
2. Download the latest version
3. Run installer with default settings
4. Complete installation

### Step 3: Install Project Dependencies
1. Open Command Prompt in the project folder
2. Run: `npm install`
3. Run: `npm install electron --save-dev`

## 🚨 Common Issues & Solutions

### "Node.js not found"
- **Solution:** Install Node.js from https://nodejs.org/
- **Note:** Download the LTS (Long Term Support) version
- **After install:** Restart your computer

### "Failed to install dependencies"
1. Check internet connection
2. Run `troubleshoot.bat` → Option 5 (Clean install)
3. Try: `npm cache clean --force`
4. Try: `npm install --force`

### "Network capture failed" / "Npcap not found"
- **Solution:** Install Npcap from https://nmap.org/npcap/
- **Important:** Use default settings during installation
- **After install:** Restart your computer

### "Permission denied" / "Access denied"
- **Solution:** Right-click the .bat file and select "Run as administrator"
- **Alternative:** Run Command Prompt as administrator first

### Downloads fail / "Failed to download"
- Check your internet connection
- Try running from a different network
- Use the manual installation links in `troubleshoot.bat`

## 🎯 Installation Process Details

### What Gets Downloaded
1. **Node.js installer** (~30MB) - JavaScript runtime
2. **Npcap installer** (~5MB) - Network packet capture
3. **npm packages** (~100MB) - Project dependencies

### Where Files Are Stored
- **Node.js:** `C:\Program Files\nodejs\`
- **npm packages:** `node_modules\` folder in project directory
- **Temporary files:** `temp\` folder (auto-deleted after install)

### Internet Requirements
- **Bandwidth:** ~150MB total download
- **Connections:** nodejs.org, npcap.com, npmjs.com
- **Time:** 5-10 minutes depending on connection speed

## 📞 Getting Help

### If Installation Fails
1. Run `troubleshoot.bat` for guided help
2. Check the error messages carefully
3. Try the manual installation steps
4. Report issues at: https://github.com/tbdestroyer/StarResonanceDamageCounter/issues

### For Usage Help
- Enhanced version: https://github.com/tbdestroyer/StarResonanceDamageCounter
- Original project: https://github.com/dmlgzs/StarResonanceDamageCounter

## 🏆 System Requirements

### Operating System
- Windows 10 or Windows 11
- Administrator privileges (for installing software)

### Hardware
- 2GB+ RAM
- 1GB+ free disk space
- Internet connection (for initial download)

### Network
- For game monitoring: Ethernet or WiFi connection to same network as game

---

**Ready to get started?** Just double-click `install-everything.bat` and follow the prompts! 🚀