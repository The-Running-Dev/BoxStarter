function ConvertTo-FullPath {
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $path,
        [parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $basePath
    )

    if ([System.IO.Path]::IsPathRooted($path) -or $path.StartsWith('http')) {
        return $path
    }

    return Join-Path -Resolve $basePath $path
}