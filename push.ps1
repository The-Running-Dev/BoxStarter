param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local'
)

Import-Module '.\Chocolatey-Dev.extension\extensions\Chocolatey-Dev.extension.psm1' -Force

Invoke-ChocoPushWithConfig $PSScriptRoot $searchTerm $sourceType