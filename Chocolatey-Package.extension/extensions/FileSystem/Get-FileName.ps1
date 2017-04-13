function Get-FileName([string] $file) {
    return [System.IO.Path]::GetFileName($file)
}