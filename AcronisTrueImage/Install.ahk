if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

SetTitleMatchMode, 2

WinWait True Image Setup ahk_class #32770
WinActivate
Sleep 1000
; Click 'Install'
MouseClick left, 120, 450
; Wait for the installer
Sleep 60000
WinWait True Image Setup ahk_class #32770
WinActivate
Sleep 1000
; Click 'Start application'
MouseClick left, 120, 450
WinWait, ahk_class Qt5QWindow
WinActivate
Sleep 1000
; Click 'I accept this agreement'
MouseClick left, 40, 725
Sleep 400
; Click 'Ok'
MouseClick left, 450, 725
Sleep 5000
WinWait, ahk_class Qt5QWindow
WinActivate
Sleep 1000
Send !{F4}