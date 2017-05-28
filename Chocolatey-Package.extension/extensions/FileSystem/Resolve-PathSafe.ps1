function Resolve-PathSafe {
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $path,
        [parameter(Position = 1, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $basePath
    )

    if ([System.IO.Path]::IsPathRooted($path) -or $path.StartsWith('http')) {
        return $path
    }

    if ($basePath) {
        return Join-Path -Resolve $basePath $path

    }

    return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}