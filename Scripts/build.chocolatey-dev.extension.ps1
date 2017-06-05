$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$parentDir = Join-Path $PSScriptRoot '..\' -Resolve

if ((choco list Chocolatey-Dev.exension -lo -r)) {
    choco uninstall Chocolatey-Dev.extension -f
    Remove-Item -Recurse C:\ProgramData\Chocolatey\extensions\chocolatey-dev -ErrorAction SilentlyContinue
}

& $parentDir\build-push.ps1 NuGet-Commandline
& $parentDir\build-push.ps1 Octopus-Deploy-CommandLine
& $parentDir\build-push.ps1 PowerShell-Carbon
& $parentDir\build-push.ps1 PowerShell-CommunityExtensions
& $parentDir\build-push.ps1 PowerShell-PSake

& $parentDir\build-push.ps1 Chocolatey-Dev.extension
choco upgrade Chocolatey-Dev.extension -s $packagesDir

Import-Module 'C:\ProgramData\Chocolatey\extensions\Chocolatey-Dev\Chocolatey-Dev.extension.psm1' -Force