function Test-DirectoryExists {
    param(
		[string] $path
	)

    return [System.IO.Directory]::Exists($path)
}