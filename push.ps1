param(
    [string] $package,
    [string] $source = 'local'
)

Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1') -Force

Push $PSScriptRoot $package $source