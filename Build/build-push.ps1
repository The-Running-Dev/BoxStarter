param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local',
    [ValidateSet('true', 'false')][string] $embed = 'true'
)

& $PSScriptRoot\build.ps1 $searchTerm $sourceType $embed
& $PSScriptRoot\push.ps1 $searchTerm $sourceType