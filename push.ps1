param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][String] $sourceType = 'local'
)

Invoke-ChocoPushWithConfig $PSScriptRoot $searchTerm $sourceType