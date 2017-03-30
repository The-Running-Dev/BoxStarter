param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local',
    [ValidateSet('true', 'false')][string] $embed = 'true'
)

& .\build.ps1 $searchTerm $sourceType $embed
& .\push.ps1 $searchTerm $sourceType