param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

$isFixedVersion = $false

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')