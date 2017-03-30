param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local'
)
Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1') -Force

Push-Packages $PSScriptRoot $searchTerm $sourceType