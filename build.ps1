param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local',
    [switch] $force
)

Invoke-ChocoPackWithConfig $PSScriptRoot $searchTerm $sourceType $force