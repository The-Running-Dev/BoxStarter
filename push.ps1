param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local'
)
Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1') -Force

Invoke-Push $PSScriptRoot $searchTerm $sourceType