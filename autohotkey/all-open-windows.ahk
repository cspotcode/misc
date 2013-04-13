#persistent

  ; How often should a list of open windows be saved?
  ; Value is in milliseconds
  interval := 60 * 1000

  ; Save the list of windows into this file
  ; List are appended to the file, so the newest list of windows is at the end
  filename := "window-log.txt"

  SetTimer, SaveWindowTitleSnapshot, % interval
  Gosub SaveWindowTitleSnapshot
return


SaveWindowTitleSnapshot:
  FormatTime, time, , yyyy-MM-dd HH-mm-ss
  ;filename := time . ".txt"


  FileAppend, % "===================`r`n" . time . "`r`n===================`r`n", % filename

  WinGet, windows, List
  Loop % windows {
    window := windows%A_Index%
    WinGetClass, windowClass, ahk_id %window%
    WinGetTitle, windowTitle, ahk_id %window%
    line := "[" . windowClass . "] " . windowTitle
    FileAppend, % line . "`r`n", % filename
  }
return