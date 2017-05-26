function Test-FileExists {
    param(
		[string] $file
	)

    return [System.IO.File]::Exists($file)
}