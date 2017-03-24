if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

WinWait, Windows Security ahk_class #32770, , 40
WinActivate
Sleep 1000
ControlClick &Install