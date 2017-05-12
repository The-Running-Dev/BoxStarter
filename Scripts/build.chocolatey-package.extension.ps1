$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$parentDir = Join-Path $PSScriptRoot '..\' -Resolve

choco uninstall Chocolatey-Package.extension -f
Remove-Item -Recurse C:\ProgramData\Chocolatey\extensions\chocolatey-Package -ErrorAction SilentlyContinue

& $parentDir\build-push.ps1 Chocolatey-Package.extension -f

choco install Chocolatey-Package.extension -f -s $packagesDir

Import-Module 'C:\ProgramData\Chocolatey\extensions\chocolatey-package\Chocolatey-Package.extension.psm1' -Force