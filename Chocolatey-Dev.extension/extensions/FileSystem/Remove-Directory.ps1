function Remove-Directory
{
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $path
    )

    Remove-Item -Recurse -Force -Path $path -ErrorAction SilentlyContinue
}