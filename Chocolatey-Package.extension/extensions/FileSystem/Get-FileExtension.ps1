function Get-FileExtension {
    param(
		[string] $file
	)

    return [System.IO.Path]::GetExtension($file).ToLower().Replace('.', '')
}