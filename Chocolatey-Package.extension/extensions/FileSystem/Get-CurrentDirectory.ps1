function Get-CurrentDirectory {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_})][string] $path
    )

    if ([System.IO.File]::Exists($path)) {
        return $(Split-Path -Parent $path)
    }

    return $path
}