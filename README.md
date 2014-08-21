Misc
===

Various scripts and tools that might be worth sharing.

The Scripts
---

### `autohotkey/all-open-windows.ahk` ###

AutoHotKey script that periodically dumps a list of all open windows into a log file.
Useful if your computer crashes or you have to reboot to install software updates, and
you want to remember everything that you had open.

### `autohotkey/ctrlL/ctrlL.ahk` ###

Adds Ctrl+L and Ctrl+K shortcuts in Windows Explorer, just like in most web browsers.

* Ctrl+L: Focus the path bar ("address bar") allowing you to start typing a file or folder path.
* Ctrl+K: Focus the search box.

Also allows forcing any window to stay on top of other windows.

To enable/disable "always-on-top" behavior for a window:

* Right-click ctrlL's tray icon
* Click "Toggle Always-on-top"
* Click on a window

### `powershell/powerplan.ps1` & `powershell/powerplan.cmd` ###

Makes it easy to switch power plans from the command prompt.  I use this on my laptop when I frequently switch between "Power saver" for longer battery life and "High Performance" for heavier computing.  It's a wrapper around `powercfg.exe`, which requires specifying the plan's GUID to switch plans.

**Usage:**
```
# To see a list of all power plans and which one is active:
> powerplan
# Switch to the "Power saver" plan (you can use partial plan names)
> powerplan saver
```

The `.cmd` script is a redirect that invokes the PowerShell script from a `cmd.exe` prompt.  To use this script from both PowerShell and `cmd.exe`, add both files to your path.