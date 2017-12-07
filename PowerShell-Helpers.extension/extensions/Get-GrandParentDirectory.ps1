function Get-GrandParentDirectory {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_})][string] $path
    )

    return Join-Path -Resolve (Get-ParentDirectory $path) ..
}