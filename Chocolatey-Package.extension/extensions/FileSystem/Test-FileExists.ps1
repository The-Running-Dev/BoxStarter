function Test-FileExists([string] $file) {
    return [System.IO.File]::Exists($file)
}