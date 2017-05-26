function Invoke-Unzip() {
    param(
        [string] $file,
        [string] $destination
    )

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file, $destination)
    }
    catch {}
}
