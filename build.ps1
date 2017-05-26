param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local',
    [switch] $force
)

Import-Module "$PSScriptRoot\Chocolatey-Dev.extension\extensions\Chocolatey-Dev.extension.psm1" -Force

Invoke-ChocoPackWithConfig $PSScriptRoot $searchTerm $sourceType $force
