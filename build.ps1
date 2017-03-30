param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local',
    [ValidateSet('true', 'false')][string] $embed = 'true'
)
Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1') -Force

New-Packages $PSScriptRoot $searchTerm $sourceType $embed