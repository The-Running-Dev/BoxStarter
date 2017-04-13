function Remove-Directory
{
    param(
        [string] $path
    )

    Remove-Item -Recurse -Force -Path $path -ErrorAction SilentlyContinue
}