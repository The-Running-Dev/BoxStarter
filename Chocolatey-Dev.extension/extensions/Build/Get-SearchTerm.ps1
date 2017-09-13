function Get-SearchTerm {
    param (
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = ''
    )

    return $searchTerm -replace '\.\\(.*?)\\', '$1'
}