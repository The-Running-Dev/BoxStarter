$packagesDir = Join-Path $PSScriptRoot '..\..\..\BoxStarter' -Resolve
$parentDir = Join-Path $PSScriptRoot '..\' -Resolve

if ((choco list Chocolatey-SQL -lo -r)) {
    choco uninstall Chocolatey-SQL.extension -f
    Remove-Item -Recurse C:\ProgramData\Chocolatey\extensions\Chocolatey-SQL -ErrorAction SilentlyContinue
}

& $parentDir\build-push.ps1 Chocolatey-SQL.extension -f

choco upgrade Chocolatey-SQL.extension -f -s $packagesDir

Import-Module 'C:\ProgramData\Chocolatey\extensions\Chocolatey-SQL\Chocolatey-SQL.extension.psm1' -Force