param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot
$setupDir = Join-Path $packageDir 'Setup'
$setupFiles = Join-Path $PSScriptRoot '..\..\..\BoxStarter\Installers\VisualStudio2015Enterprise' -Resolve
$setupFile = Join-Path $setupDir 'vs_enterprise.exe'

. (Join-Path $PSScriptRoot '..\Scripts\update.onchange.begin.ps1')

function global:au_BeforeUpdate {
    if (-not (Test-Path $setupFile)) {
        New-Item -ItemType Directory $setupDir
        Copy-Item -Recurse $setupFiles\* $setupDir\
        New-Item -ItemType File "$setupFile.ignore"
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')