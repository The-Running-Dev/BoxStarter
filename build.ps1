param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][string] $sourceType = 'local',
    [switch] $force
)

Invoke-ChocoPack $PSScriptRoot $searchTerm $sourceType $force