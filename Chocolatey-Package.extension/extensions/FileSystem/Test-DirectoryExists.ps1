function Test-DirectoryExists([string] $path) {
    return [System.IO.Directory]::Exists($path)
}