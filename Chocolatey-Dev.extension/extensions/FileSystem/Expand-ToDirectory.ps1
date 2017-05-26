function Expand-ToDirectory()
{
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string] $file,
        [Parameter(Position = 1, Mandatory = $true, ValueFromPipeline = $true)][string] $destination
    )

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file, $destination)
    }
    catch {}
}