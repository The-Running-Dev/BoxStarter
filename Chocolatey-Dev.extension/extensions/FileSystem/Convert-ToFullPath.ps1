function Convert-ToFullPath {
    param (
        [parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string] $path,
        [parameter(Position = 1, Mandatory = $true, ValueFromPipeline = $true)][string] $basePath
    )

    if ([System.IO.Path]::IsPathRooted($path) -or $path.StartsWith('http')) {
        return $path
    }

    return Join-Path -Resolve $basePath $path
}