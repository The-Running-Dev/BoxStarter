function Get-FileName {
    param(
		[string] $file
	)

    return [System.IO.Path]::GetFileName($file)
}