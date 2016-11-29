if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

SetTitleMatchMode, 2

WinWait, Razer Synapse - InstallShield Wizard ahk_class MsiDialogCloseClass, Welcome,
WinActivate
ControlClick, &Next >, Razer Synapse - InstallShield Wizard ahk_class MsiDialogCloseClass
Sleep, 400
ControlClick, Button3, Razer Synapse - InstallShield Wizard ahk_class MsiDialogCloseClass
Sleep, 400
ControlClick, &Next >, Razer Synapse - InstallShield Wizard ahk_class MsiDialogCloseClass
Sleep, 400
ControlClick, Install, Razer Synapse - InstallShield Wizard ahk_class MsiDialogCloseClass
WinWait, Razer Synapse - InstallShield Wizard ahk_class MsiDialogCloseClass, Completed,
WinActivate
ControlClick, Button3
Sleep, 400
ControlClick, &Finish