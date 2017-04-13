function Get-FileExtension([string] $file) {
    return [System.IO.Path]::GetExtension($file).ToLower()
}