param (
    [Parameter(Position = 0)][String] $searchTerm,
    [Parameter(Position = 1)][switch] $remote,
    [Parameter(Position = 2)][switch] $force
)

Invoke-ChocoPack $PSScriptRoot $searchTerm $remote $force