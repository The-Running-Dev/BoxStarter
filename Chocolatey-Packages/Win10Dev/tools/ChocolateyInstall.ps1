# The command to run, built from the raw link of this gist
# start http://bit.ly/win10boxstarter
Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Win10Dev.psm1')

########################################
# Boxstarter options
########################################
# Don't allow reboots
$Boxstarter.RebootOk = $true

# Is this a machine with no login password
$Boxstarter.NoPassword = $false

# Save password securely and auto-login after a reboot
$Boxstarter.AutoLogin = $true
########################################

########################################
# Window Configuration. See http://boxstarter.org/WinConfig
########################################
Write-BoxstarterMessage "Configuring Windows"

Update-ExecutionPolicy Unrestricted

Enable-RemoteDesktop

Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -EnableShowAppsViewOnStartScreen -EnableSearchEverywhereInAppsView -EnableListDesktopAppsFirst

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableShowFullPathInTitleBar -DisableOpenFileExplorerToQuickAccess -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess -EnableExpandToOpenFolder

Disable-UAC
if (Test-PendingReboot) { Invoke-Reboot }

Disable-GameBarTips

Disable-InternetExplorerESC

Set-TaskbarOptions -Size Small -Lock -Dock Bottom -Combine Full

Disable-WindowsFeatures
if (Test-PendingReboot) { Invoke-Reboot }

Enable-WindowsFeatures
if (Test-PendingReboot) { Invoke-Reboot }
########################################

########################################
# Applications. See https://chocolatey.org/packages
########################################
Write-BoxstarterMessage "Installing Applications"

Install-Applications

# Additonal software that doesn't have packages
# ESET
# EditPad Pro C:\EditPad\SetupEditPadPro736.exe /silent
# ACDSee
#
# Already installed as portable apps
# PreCode
# cinst Slack
# cinst MySql.Workbench
# cinst Spotify
########################################

########################################
# Registry Settings
########################################
Write-BoxstarterMessage "Configuring Registry"

# Set TimeZone to NTP and enable sync
# [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters](time) "Type"="NoSync"(off) "Type"="NTP" (on)
#
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters"
$name = "Type"
$value = "NTP"
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType String -Force | Out-Null

# [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tzautoupdate](time zone) "Start"=dword:00000003 (off) "Start"=dword:00000004 (on)
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate"
$name = "Type"
$value = "4"
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
########################################

########################################
# SQL Server
########################################
# ToDo: Create SQL Server NuGet package with ability to take Configuration file URL
# See VS package for example: https://chocolatey.org/packages/VisualStudio2015Enterprise
# cinst http://path.to.NuGet.Package
# if (Test-PendingReboot) { Invoke-Reboot }
########################################

########################################
# Taskbar Icons
########################################

########################################
# Windows Updates
########################################
Enable-MicrosoftUpdate

#Install-WindowsUpdate -AcceptEula -Criteria "IsAssigned=1 and IsHidden=0 and IsInstalled=0" -SuppressReboots
if (Test-PendingReboot) { Invoke-Reboot }

# Set the computer name
Rename-Computer -NewName "NewPC"