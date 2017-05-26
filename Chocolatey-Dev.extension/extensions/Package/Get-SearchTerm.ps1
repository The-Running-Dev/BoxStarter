function Get-SearchTerm {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipeline)][string] $searchTerm
    )

    return $searchTerm -replace '\.\\(.*?)\\', '$1'
}