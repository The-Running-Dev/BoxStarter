param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][string] $sourceType = 'local'
)

Import-Module '.\Chocolatey-Dev.extension\extensions\Chocolatey-Dev.extension.psm1' -Force

Invoke-ChocoPush $PSScriptRoot $searchTerm $sourceType