function Get-ParentDirectory {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_})][string] $path
    )

    if ([System.IO.File]::Exists($path)) {
        return Join-Path -Resolve $(Split-Path -Parent $path) ..
    }

    return Join-Path -Resolve $path ..
}