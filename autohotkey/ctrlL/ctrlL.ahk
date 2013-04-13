#persistent
If (A_OSVersion == "WIN_VISTA" or A_OSVersion == "WIN_7")
{
  ; Win7
  mode = win7
  explorerClass = CabinetWClass
} else {
  ; XP
  mode = xp
  explorerClass = ExploreWClass
}

Menu, TRAY, Icon, ctrlL.ico

; remove default junk from the menu, then add the items I really need
Menu, TRAY, NoStandard
Menu, TRAY, Add, Reload, Menu_Reload

; setup the tray icon menu to allow setting windows as always-on-top
Menu, TRAY, Add, Toggle Always-on-top, Menu_ToggleOnTop

; Add exit option
Menu, TRAY, Add, Exit, Menu_Exit

Hotkey, LButton, Hotkey_ToggleOnTop, Off
return

#if, WinActive("ahk_class " . explorerClass)
; pressing Ctrl-L in explorer will put text edit focus onto the path
^l::
  If (mode = "xp")
  {
    ControlFocus, Edit1, A
  } else {
    ControlClick, ToolbarWindow322, A, , , , X0
  }
  return

^k::
  If (mode = "xp")
  {
    ControlFocus, Edit2, A  ; TODO does this actually work?
  } else {
    ControlClick, DirectUIHWND1, A, , , , 
  }
  return

#ifWinActive, ahk_class IEFrame

; pressing Ctrl-L in IE will put text edit focus in the URL bar
;^l::
;  ControlFocus, Edit1, A
;  return

; pressing Ctrl-K in IE will put text edit focus in the search bar
^k::
  ControlFocus, Edit2, A
  return

#If

Menu_ToggleOnTop:
Hotkey, LButton, Toggle
return

Hotkey_ToggleOnTop:
MouseGetPos, , , temp
WinSet, AlwaysOnTop, Toggle, ahk_id %temp%
Hotkey, LButton, Off
return

Menu_Reload:
Reload
return

Menu_Exit:
ExitApp
return