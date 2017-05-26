function Clear-Directory {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Container})][string] $path,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][string[]] $exclude
    )

    Remove-Item -Path $path\** -Exclude $exclude -Recurse -Force -ErrorAction SilentlyContinue
}