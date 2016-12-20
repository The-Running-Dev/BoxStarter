if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

SetTitleMatchMode, 2

WinWait LastPass for Applications Setup ahk_class #32770
WinActivate
Sleep 1000
; Click Next
ControlClick &Next >
Sleep 1000
; Click 'Install'
ControlClick &Install
; Wait for the Install
Sleep 10000
; Unckeck 'Run...'
ControlClick &Run LastPass for Applications
Sleep 1000
; Click 'Finish'
ControlClick &Finish