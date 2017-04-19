param (
    [string] $package
)

$packageDir = Split-Path -Parent (Get-ChildItem -Recurse "$package.nuspec")

$env:ChocoDebug = $true
$env:ChocolateyPackageName = $package
$env:ChocolateyPackageTitle = $package
$env:ChocolateyPackageFolder = $packageDir

Import-Module '..\BoxStarter\Chocolatey-Package.extension\extensions\Chocolatey-Package.extension.psm1' -Force

& $env:ChocolateyPackageFolder\tools\ChocolateyInstall.ps1