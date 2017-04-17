$env:ChocoDebug = $true
$env:ChocolateyPackageName = 'XYPlorer'
$env:ChocolateyPackageTitle = 'XYPlorer'
$env:ChocolateyPackageFolder = Join-Path $PSScriptRoot .. -Resolve

Import-Module 'D:\Dropbox\Projects\BoxStarter\Chocolatey-Package.extension\extensions\Chocolatey-Package.extension.psm1' -Force

& $PSScriptRoot\ChocolateyInstall.ps1