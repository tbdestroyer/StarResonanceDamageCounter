const { app, BrowserWindow, globalShortcut } = require('electron');

let overlayWindow = null;
let isVisible = true;
let mouseEventsIgnored = true; // Track this manually

function createOverlay() {
    console.log('Creating overlay window...');
    overlayWindow = new BrowserWindow({
        width: 400,  // Slightly larger for easier resizing
        height: 300,
        frame: true,  // Normal frame with title bar
        transparent: false, // Non-transparent for better visibility
        alwaysOnTop: true,
        skipTaskbar: false, // Show in taskbar so you can find it
        resizable: true,
        minimizable: false,
        maximizable: false,
        fullscreenable: false, // Prevent fullscreen to maintain always-on-top
        webPreferences: {
            nodeIntegration: false,
            contextIsolation: true,
            webSecurity: false
        }
    });

    // Set additional always-on-top properties for fullscreen compatibility
    overlayWindow.setAlwaysOnTop(true, 'screen-saver');
    overlayWindow.setVisibleOnAllWorkspaces(true, { visibleOnFullScreen: true });

    // Add a small delay to ensure server is ready, then load the URL
    setTimeout(() => {
        console.log('Loading overlay URL...');
        overlayWindow.loadURL('http://localhost:8989/?overlay=compact');
    }, 1000);
    
    overlayWindow.on('closed', () => {
        console.log('Overlay window was closed');
        overlayWindow = null;
    });

    overlayWindow.webContents.on('did-fail-load', (event, errorCode, errorDescription, validatedURL) => {
        console.log(`Failed to load URL: ${validatedURL}`);
        console.log(`Error: ${errorCode} - ${errorDescription}`);
        // Don't close the app on load failure, keep window open
    });
    
    // Wait for page to load, then inject overlay mode
    overlayWindow.webContents.once('dom-ready', () => {
        // Set zoom to actual size (100%)
        overlayWindow.webContents.setZoomFactor(1.0);
        
        overlayWindow.webContents.executeJavaScript(`
            document.body.classList.add('overlay-mode');
            document.body.classList.add('view-both'); // Default view
            document.body.classList.add('simple-mode'); // Enable simple mode by default
            document.body.setAttribute('data-view-mode', 'Both (Simple)');
            console.log('Overlay mode applied via injection');
            
            // View toggle functionality
            let currentView = 0; // 0 = both, 1 = chart only, 2 = table only
            const viewModes = [
                { class: 'view-both', name: 'Both' },
                { class: 'view-chart-only', name: 'Chart' },
                { class: 'view-table-only', name: 'Table' }
            ];
            
            // Simple mode toggle functionality
            let isSimpleMode = true; // Start with simple mode enabled
            
            window.toggleSimpleMode = function() {
                isSimpleMode = !isSimpleMode;
                if (isSimpleMode) {
                    document.body.classList.add('simple-mode');
                } else {
                    document.body.classList.remove('simple-mode');
                }
                
                // Update view indicator to show simple mode status
                const currentMode = viewModes[currentView].name;
                const modeText = isSimpleMode ? currentMode + ' (Simple)' : currentMode;
                document.body.setAttribute('data-view-mode', modeText);
                
                console.log('Simple mode:', isSimpleMode ? 'enabled' : 'disabled');
            };
            
            // Override chart initialization for overlay optimization
            window.overlayChartEnhancer = function() {
                // Wait for chart to be initialized
                const checkChart = setInterval(() => {
                    if (window.chart && window.chart.getOption) {
                        console.log('Enhancing chart for overlay...');
                        
                        // Get current chart option
                        const option = window.chart.getOption();
                        
                        // Apply overlay-optimized settings
                        window.chart.setOption({
                            animation: false,
                            series: option.series.map(series => ({
                                ...series,
                                smooth: false,
                                connectNulls: true,
                                sampling: 'lttb', // Use Lanczos sampling for better line quality
                                lineStyle: {
                                    ...series.lineStyle,
                                    width: series.lineStyle?.width || 2
                                }
                            })),
                            grid: {
                                left: '15%',
                                right: '10%',
                                bottom: '20%',
                                top: '15%',
                                containLabel: true
                            }
                        }, true);
                        
                        // Force immediate resize
                        window.chart.resize();
                        clearInterval(checkChart);
                    }
                }, 500);
                
                // Safety timeout
                setTimeout(() => clearInterval(checkChart), 10000);
            };
            
            // Start chart enhancement after DOM ready
            setTimeout(() => {
                window.overlayChartEnhancer();
                
                // Enable hide inactive by default
                if (typeof toggleHideInactiveUsers === 'function') {
                    // Only toggle if not already active
                    if (!window.hideInactiveUsers) {
                        toggleHideInactiveUsers();
                    }
                }
                
                // Set default data group to 'damage' for cleaner overlay
                document.body.setAttribute('data-current-group', 'damage');
                
                // Override data group tracking
                window.originalToggleDataGroup = window.toggleDataGroup;
                window.toggleDataGroup = function(group) {
                    if (window.originalToggleDataGroup) {
                        window.originalToggleDataGroup(group);
                    }
                    document.body.setAttribute('data-current-group', group);
                    console.log('Data group changed to:', group);
                };
            }, 2000);
            
            window.toggleView = function() {
                // Remove current view class
                document.body.classList.remove(viewModes[currentView].class);
                
                // Move to next view
                currentView = (currentView + 1) % viewModes.length;
                
                // Add new view class
                document.body.classList.add(viewModes[currentView].class);
                
                // Update view indicator with simple mode status
                const modeText = isSimpleMode ? viewModes[currentView].name + ' (Simple)' : viewModes[currentView].name;
                document.body.setAttribute('data-view-mode', modeText);
                
                console.log('View switched to:', viewModes[currentView].name);
            };
            
            // Auto-scale both table and chart proportionally
            function autoScale() {
                const windowWidth = window.innerWidth;
                const windowHeight = window.innerHeight;
                
                // Calculate optimal chart size based on window width
                const maxChartWidth = Math.min(windowWidth - 20, 600); // 10px margin on each side
                const chartWidth = Math.max(maxChartWidth, 300); // Minimum 300px for readability
                const chartHeight = Math.round(chartWidth * 0.2); // 5:1 aspect ratio
                const actualChartHeight = Math.min(Math.max(chartHeight, 60), 120); // Between 60-120px
                
                // Reserve space for chart and calculate remaining space for table
                const chartContainerHeight = actualChartHeight + 20; // Include padding
                const availableHeight = windowHeight - chartContainerHeight - 20;
                
                // Base table size
                const baseTableWidth = 400;
                const baseTableHeight = 180;
                
                // Calculate scale factors for table
                const widthScale = windowWidth / baseTableWidth;
                const heightScale = Math.max(availableHeight / baseTableHeight, 0.3);
                
                const scale = Math.min(widthScale, heightScale, 2.0);
                const finalScale = Math.max(scale, 0.3);
                
                // Apply zoom only to table
                document.documentElement.style.setProperty('--overlay-zoom', finalScale);
                
                // Set chart dimensions proportionally
                setTimeout(() => {
                    const canvas = document.querySelector('canvas');
                    if (canvas) {
                        // Set proportional dimensions
                        canvas.style.width = chartWidth + 'px';
                        canvas.style.height = actualChartHeight + 'px';
                        
                        // If chart exists, force resize
                        if (canvas.chart && canvas.chart.resize) {
                            canvas.chart.resize();
                        }
                        
                        // Trigger chart redraw
                        window.dispatchEvent(new Event('resize'));
                    }
                }, 300);
                
                // Improve chart rendering and text styling for overlay
                setTimeout(() => {
                    if (window.chart) {
                        // Force chart resize first
                        window.chart.resize();
                        
                        // Then apply better styling
                        if (window.chart.setOption) {
                            const currentOption = window.chart.getOption();
                            if (currentOption && currentOption.yAxis && currentOption.yAxis[0]) {
                                window.chart.setOption({
                                    animation: false, // Disable animations for better performance
                                    yAxis: {
                                        ...currentOption.yAxis[0],
                                        axisLabel: {
                                            fontSize: 11,
                                            fontWeight: 'bold',
                                            color: '#ffffff',
                                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                                            padding: [2, 3, 2, 3],
                                            borderRadius: 2
                                        }
                                    },
                                    xAxis: {
                                        ...currentOption.xAxis[0],
                                        axisLabel: {
                                            fontSize: 10,
                                            color: '#cccccc'
                                        }
                                    },
                                    grid: {
                                        left: '12%',
                                        right: '8%',
                                        bottom: '15%',
                                        top: '10%',
                                        containLabel: true
                                    }
                                }, false);
                            }
                        }
                    }
                }, 800);
                
                console.log('Table scaled to: ' + finalScale + ', Chart: ' + chartWidth + 'x' + actualChartHeight + 'px');
            }
            
            // Auto-scale on load and resize
            autoScale();
            
            // Enhanced resize handler for chart
            let resizeTimeout;
            window.addEventListener('resize', () => {
                clearTimeout(resizeTimeout);
                resizeTimeout = setTimeout(() => {
                    autoScale();
                    
                    // Force chart redraw after resize
                    if (window.chart) {
                        setTimeout(() => {
                            window.chart.resize();
                        }, 100);
                    }
                }, 150);
            });
        `);
    });
    
    // Start in click-through mode for gaming
    overlayWindow.setIgnoreMouseEvents(true);
    mouseEventsIgnored = true;
    
    // Position at top-right corner
    const { screen } = require('electron');
    const display = screen.getPrimaryDisplay();
    const { width } = display.workAreaSize;
    overlayWindow.setPosition(width - 320, 20);

    // Set opacity
    overlayWindow.setOpacity(0.85);

    // Register hotkeys
    registerHotkeys();

    overlayWindow.on('closed', () => {
        overlayWindow = null;
    });

    console.log('Overlay created! You can drag the title bar to move it.');
    console.log('Hotkeys:');
    console.log('  F9  - Toggle visibility');
    console.log('  F10 - Toggle click-through mode (for gaming)');
    console.log('  F12 - Toggle opacity (0.85 <-> 0.5)');
    console.log('');
    console.log('Drag title bar to move, drag edges/corners to resize!');
}

function registerHotkeys() {
    // Toggle visibility with F9
    globalShortcut.register('F9', () => {
        if (overlayWindow) {
            isVisible = !isVisible;
            if (isVisible) {
                overlayWindow.show();
                console.log('Overlay shown');
            } else {
                overlayWindow.hide();
                console.log('Overlay hidden');
            }
        }
    });

    // Toggle mouse interaction with F10 - SIMPLIFIED WITHOUT RECREATION
    globalShortcut.register('F10', () => {
        if (overlayWindow) {
            mouseEventsIgnored = !mouseEventsIgnored;
            overlayWindow.setIgnoreMouseEvents(mouseEventsIgnored);
            
            // Just show/hide frame visually with CSS
            if (!mouseEventsIgnored) {
                overlayWindow.webContents.executeJavaScript(`
                    document.body.style.border = '3px solid #4CAF50';
                    document.body.style.borderRadius = '4px';
                    document.body.style.cursor = 'move';
                    console.log('Interactive mode - drag anywhere to move window');
                `);
                // Make the overlay temporarily non-transparent for better visibility when dragging
                overlayWindow.setOpacity(0.95);
            } else {
                overlayWindow.webContents.executeJavaScript(`
                    document.body.style.border = 'none';
                    document.body.style.borderRadius = '0';
                    document.body.style.cursor = 'default';
                `);
                // Back to semi-transparent
                overlayWindow.setOpacity(0.85);
            }
            
            console.log(`Mouse interaction: ${mouseEventsIgnored ? 'DISABLED (click-through)' : 'ENABLED (window is now interactive)'}`);
        }
    });

    // Toggle simple mode with F1
    globalShortcut.register('F1', () => {
        if (overlayWindow) {
            overlayWindow.webContents.executeJavaScript(`
                if (typeof window.toggleSimpleMode === 'function') {
                    window.toggleSimpleMode();
                }
            `);
        }
    });

    // Toggle to Damage/DPS view with F2
    globalShortcut.register('F2', () => {
        if (overlayWindow) {
            overlayWindow.webContents.executeJavaScript(`
                if (typeof toggleDataGroup === 'function') {
                    toggleDataGroup('damage');
                }
            `);
        }
    });

    // Toggle to Healing/HPS view with F3
    globalShortcut.register('F3', () => {
        if (overlayWindow) {
            overlayWindow.webContents.executeJavaScript(`
                if (typeof toggleDataGroup === 'function') {
                    toggleDataGroup('healing');
                }
            `);
        }
    });

    // Toggle to All Data view with F4
    globalShortcut.register('F4', () => {
        if (overlayWindow) {
            overlayWindow.webContents.executeJavaScript(`
                if (typeof toggleDataGroup === 'function') {
                    toggleDataGroup('all');
                }
            `);
        }
    });

    // Toggle Hide Inactive with F5
    globalShortcut.register('F5', () => {
        if (overlayWindow) {
            overlayWindow.webContents.executeJavaScript(`
                if (typeof toggleHideInactiveUsers === 'function') {
                    toggleHideInactiveUsers();
                }
            `);
        }
    });

    // Toggle view mode with F11
    globalShortcut.register('F11', () => {
        if (overlayWindow) {
            overlayWindow.webContents.executeJavaScript(`
                if (typeof window.toggleView === 'function') {
                    window.toggleView();
                }
            `);
        }
    });

    // Toggle opacity with F12
    globalShortcut.register('F12', () => {
        if (overlayWindow) {
            const currentOpacity = overlayWindow.getOpacity();
            const newOpacity = currentOpacity > 0.7 ? 0.5 : 0.85;
            overlayWindow.setOpacity(newOpacity);
            console.log(`Opacity: ${Math.round(newOpacity * 100)}%`);
        }
    });
}

app.whenReady().then(() => {
    createOverlay();
});

app.on('window-all-closed', () => {
    console.log('All windows closed');
    globalShortcut.unregisterAll();
    if (process.platform !== 'darwin') {
        console.log('Quitting application');
        app.quit();
    }
});



app.on('before-quit', () => {
    globalShortcut.unregisterAll();
});