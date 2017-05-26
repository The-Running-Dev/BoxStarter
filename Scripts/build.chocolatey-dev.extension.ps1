$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$parentDir = Join-Path $PSScriptRoot '..\' -Resolve

if ((choco list Chocolatey-Dev -lo -r)) {
    choco uninstall Chocolatey-Dev.extension -f
    Remove-Item -Recurse C:\ProgramData\Chocolatey\extensions\chocolatey-dev -ErrorAction SilentlyContinue
}

& $parentDir\build-push.ps1 NuGet-Commandline -f
& $parentDir\build-push.ps1 Octopus-Deploy-CommandLine -f
& $parentDir\build-push.ps1 PowerShell-Carbon -f
& $parentDir\build-push.ps1 PowerShell-CommunityExtensions -f
& $parentDir\build-push.ps1 PowerShell-Psake -f
& $parentDir\build-push.ps1 Chocolatey-Dev.extension -f

choco upgrade Chocolatey-Dev.extension -f -s $packagesDir

Import-Module 'C:\ProgramData\Chocolatey\extensions\chocolatey-dev\Chocolatey-Dev.extension.psm1' -Force