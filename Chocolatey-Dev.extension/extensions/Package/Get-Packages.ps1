function Get-Packages {
    param (
        [parameter(Position = 0, Mandatory = $true)][string] $baseDir,
        [parameter(Position = 1, Mandatory = $false)][string] $searchTerm = '',
        [parameter(Position = 2, Mandatory = $false)][string] $filter = ''
    )

    if (!$searchTerm) {
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