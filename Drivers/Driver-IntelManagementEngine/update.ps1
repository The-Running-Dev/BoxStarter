param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\_Scripts\update.onchange.begin.ps1')

$settingsDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\..\_Scripts\update.onchange.end.ps1')