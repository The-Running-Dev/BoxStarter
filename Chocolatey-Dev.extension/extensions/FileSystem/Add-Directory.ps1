function Add-Directory {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string] $path
    )

    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }

    New-Item -ItemType Directory -Force -Path $path | Out-Null
}