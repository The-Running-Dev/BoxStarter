function Get-GrandParentDirectory([string] $path) {
    return Join-Path -Resolve (Get-ParentDirectory $path) ..
}