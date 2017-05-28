param (
    [string] $searchTerm,
    [ValidateSet('Remote', 'Local')][string] $sourceType = 'local'
)

Invoke-ChocoPush $PSScriptRoot $searchTerm $sourceType