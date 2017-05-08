function Get-SearchTerm {
    param (
        [Parameter(Position = 0, Mandatory = $false)][String] $searchTerm = ''
    )

    return $searchTerm -replace '\.\\(.*?)\\', '$1'
}