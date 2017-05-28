$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$parentDir = Join-Path $PSScriptRoot '..\' -Resolve

if ((choco list Chocolatey-Package.extension -lo -r)) {
    choco uninstall Chocolatey-Package.extension -f
    Remove-Item -Recurse C:\ProgramData\Chocolatey\extensions\Chocolatey-Package -ErrorAction SilentlyContinue
}

& $parentDir\build-push.ps1 Chocolatey-Package.extension -f

choco upgrade Chocolatey-Package.extension -f -s $packagesDir

Import-Module 'C:\ProgramData\Chocolatey\extensions\Chocolatey-Package\Chocolatey-Package.extension.psm1' -Force