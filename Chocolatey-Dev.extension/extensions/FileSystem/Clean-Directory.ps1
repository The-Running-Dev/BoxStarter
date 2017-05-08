function Clear-Directory
{
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string] $path,
        [Parameter(Position = 1, ValueFromPipeline = $true)][string[]] $exclude
    )

    Remove-Item -Path $path\** -exclude $exclude -recurse -force
}