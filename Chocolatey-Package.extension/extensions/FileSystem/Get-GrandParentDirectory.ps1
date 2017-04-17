function Get-GrandParentDirectory {
    param(
		[string] $path
	)

    return Join-Path -Resolve (Get-ParentDirectory $path) ..
}