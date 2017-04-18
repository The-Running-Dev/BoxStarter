param (
    [string] $package
)

$env:ChocoDebug = $true
$env:ChocolateyPackageName = $package
$env:ChocolateyPackageTitle = $package
$env:ChocolateyPackageFolder = Join-Path $PSScriptRoot "..\$package" -Resolve

Import-Module '..\BoxStarter\Chocolatey-Package.extension\extensions\Chocolatey-Package.extension.psm1' -Force

& $env:ChocolateyPackageFolder\tools\ChocolateyInstall.ps1