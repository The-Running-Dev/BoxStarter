function Add-Directory
{
    param(
        [string] $path
    )

    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }

    New-Item -ItemType Directory -Force -Path $path | Out-Null
}