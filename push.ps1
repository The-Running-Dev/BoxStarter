param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local'
)

Import-Module 'D:\Dropbox\Projects\BoxStarter\Chocolatey-Dev.extension\extensions\Chocolatey-Dev.extension.psm1' -Force

Invoke-ChocoPushWithConfig $PSScriptRoot $searchTerm $sourceType