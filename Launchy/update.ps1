param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot
$global:au_isFixedVersion = $true

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')