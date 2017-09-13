function Clear-Directory
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $path,
        [Parameter(ValueFromPipeline = $true)][string[]] $exclude
    )

    Remove-Item -Path $path\** -exclude $exclude -recurse -force
}