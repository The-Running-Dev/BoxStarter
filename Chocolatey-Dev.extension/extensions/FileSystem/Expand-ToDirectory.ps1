function Expand-ToDirectory()
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $file,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $destination
    )

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file, $destination)
    }
    catch {}
}