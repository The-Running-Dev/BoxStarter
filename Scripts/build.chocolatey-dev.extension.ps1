$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$parentDir = Join-Path $PSScriptRoot '..\' -Resolve

choco uninstall Chocolatey-Dev.extension -f -ErrorAction SilentlyContinue
Remove-Item -Recurse C:\ProgramData\Chocolatey\extensions\chocolatey-dev -ErrorAction SilentlyContinue

& $parentDir\build-push.ps1 NuGet-Commandline -f
& $parentDir\build-push.ps1 Octopus-Tools -f
#& $parentDir\build-push.ps1 psake
& $parentDir\build-push.ps1 pscx -f
& $parentDir\build-push.ps1 Octopus-Tools -f
& $parentDir\build-push.ps1 Chocolatey-Dev.extension -f

choco install Chocolatey-Dev.extension -f -s $packagesDir

Import-Module 'C:\ProgramData\Chocolatey\extensions\chocolatey-dev\Chocolatey-Dev.extension.psm1' -Force