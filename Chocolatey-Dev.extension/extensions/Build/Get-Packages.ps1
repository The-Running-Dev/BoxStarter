function Get-Packages {
    param (
        [parameter(Mandatory = $true)][string] $baseDir,
        [parameter(Mandatory = $false)][string] $searchTerm = '',
        [parameter(Mandatory = $false)][string] $filter = ''
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