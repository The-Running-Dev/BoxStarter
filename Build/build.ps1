param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local'
)
Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1') -Force

$parentDir = Split-Path -Parent $PSScriptRoot

Invoke-Pack $parentDir $searchTerm $sourceType