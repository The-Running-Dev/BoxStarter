if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

SetTitleMatchMode, 2

WinWait, ESET NOD32 Antivirus ahk_class #32770,,
WinActivate
Sleep, 1000
; Click Continue
MouseClick left, 50, 590
Sleep, 15000
; Click 'I Accept'
MouseClick left, 50, 590
Sleep, 1000
; Click 'Enable ...'
MouseClick left, 40, 410
Sleep, 1000
; Click 'Install'
MouseClick left, 50, 590
; Wait for the install
Sleep, 60000
; Click 'Done'
MouseClick left, 50, 590
WinWait, ESET NOD32 Antivirus ahk_class ESET Main Frame,,
WinActivate
Send, !{F4}