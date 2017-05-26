function Get-Packages {
    [CmdletBinding()]
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $baseDir,
        [parameter(Position = 1, ValueFromPipelineByPropertyName)][string] $searchTerm,
        [parameter(Position = 2, ValueFromPipelineByPropertyName)][string] $filter
    )

    if (-not $searchTerm) {
        # Get all packages in the base directory and sub directories
        $packages = (Get-ChildItem -Path $baseDir -Filter $filter -Recurse)
    }
    else {
        $packages = @()

        foreach ($p in $searchTerm.split(' ')) {
            $packages += Get-ChildItem -Path $baseDir -Filter $filter -Recurse | Where-Object { $_.Name -match ".*?$p.*"}
        }
    }

    return $packages
}