param(
    [string] $package,
    [string] $source = 'local',
    [string] $embed = ''
)

Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1') -Force

Package $PSScriptRoot $package $source $embed