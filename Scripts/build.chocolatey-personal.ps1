$parentDir = Join-Path $PSScriptRoot '..\' -Resolve
$boxstarterDir = Join-Path $PSScriptRoot '..\..\BoxStarter' -Resolve

& $boxstarterDir\build-push.ps1 Chocolatey-Package.extension -f
& $parentDir\build-push.ps1 PowerShell-Profile -f
& $parentDir\build-push.ps1 Chocolatey-Personal -f
