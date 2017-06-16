param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.begin.ps1')

$isFixedVersion = $false

. (Join-Path $PSScriptRoot '..\..\BoxStarter-Scripts\update.end.ps1')