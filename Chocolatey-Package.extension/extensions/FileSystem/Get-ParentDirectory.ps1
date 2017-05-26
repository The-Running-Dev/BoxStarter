function Get-ParentDirectory {
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $path
    )

    if ([System.IO.File]::Exists($path)) {
        return Join-Path -Resolve $(Split-Path -Parent $path) ..
    }

    return Join-Path -Resolve $path ..
}