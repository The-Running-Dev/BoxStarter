param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local'
)

$parentDir = Split-Path -Parent $PSScriptRoot
Invoke-ChocoPackWithConfig $parentDir $searchTerm $sourceType