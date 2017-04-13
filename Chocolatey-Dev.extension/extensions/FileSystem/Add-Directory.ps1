function Add-Directory
{
    param(
        [string] $path
    )

    New-Item -ItemType Directory -Force -Path $path
}