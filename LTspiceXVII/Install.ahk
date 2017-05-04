if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

SetTitleMatchMode, 2

WinWait LTspice XVII Installer ahk_class #32770
WinActivate
Sleep 1000
; Click on 'Accept'
ControlClick Button4
Sleep 400
; Click on 'Install Now'
ControlClick Button1
; Wait for the 'OK' to popup
WinWait LTspiceXVII ahk_class #32770
WinActivate
; Click on 'OK'
ControlClick Button1
; Wait for the application to start
WinWait LTspice XVII
WinActivate
Send !{F4}