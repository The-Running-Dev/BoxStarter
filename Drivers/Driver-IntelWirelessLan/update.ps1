param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot
$settingsDir = $PSScriptRoot
$keepVersionTheSame = $true

. (Join-Path $PSScriptRoot '..\..\Scripts\update.onchange.begin.ps1')

. (Join-Path $PSScriptRoot '..\..\Scripts\update.end.ps1')