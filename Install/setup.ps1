$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$parentDir = Split-Path -Parent $currentDir

$env:log = "$env:UserProfile\Desktop\BoxStarter.log"
$env:packagesSourcePath = Join-Path -Resolve $parentDir '..\BoxStarter'

& $currentDir\install.choco.ps1

choco install Chocolatey-Personal -s $env:packagesSourcePath