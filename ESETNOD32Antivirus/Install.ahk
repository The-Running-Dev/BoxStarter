if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

SetTitleMatchMode, 2

WinWait ESET NOD32 Antivirus ahk_class #32770
WinActivate
Sleep 1000
; Click Continue
MouseClick left, 50, 580
Sleep 5000
; Click 'Accept'
MouseClick left, 50, 580
Sleep 400
; Click 'Uncheck Enable ...'
MouseClick left, 40, 210
Sleep 400
; Click 'Check Disable ...'
MouseClick left, 40, 390
Sleep 400
; Click 'Install'
MouseClick left, 50, 580
; Wait for the install
Sleep 30000
; Click 'Done'
MouseClick left, 50, 580