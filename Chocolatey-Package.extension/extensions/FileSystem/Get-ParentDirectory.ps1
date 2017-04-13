function Get-ParentDirectory([string] $path) {
    if ([System.IO.File]::Exists($path)) {
        return Join-Path -Resolve $(Split-Path -Parent $path) ..
    }

    return Join-Path -Resolve $path ..
}