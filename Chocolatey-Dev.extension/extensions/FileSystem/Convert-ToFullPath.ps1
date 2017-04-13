function Convert-ToFullPath {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $path,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $basePath
    )

    if ([System.IO.Path]::IsPathRooted($path) -or $path.StartsWith('http')) {
        return $path
    }

    return Join-Path -Resolve $basePath $path
}