param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][string] $sourceType = 'local',
    [switch] $force
)

Import-Module "$PSScriptRoot\Chocolatey-Dev.extension\extensions\Chocolatey-Dev.extension.psm1" -Force

Invoke-ChocoPack $PSScriptRoot $searchTerm $sourceType $force
