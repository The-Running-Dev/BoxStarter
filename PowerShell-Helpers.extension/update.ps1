param([switch] $force)

$packageDir = $PSScriptRoot
$global:au_isFixedVersion = $false

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')