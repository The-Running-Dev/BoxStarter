function Get-Executable([string] $baseDir, [string] $fileName, [string] $regEx) {
    if (!$fileName -and !$regEx) {
        Write-Verbose 'Get-Executable: No file name or regular expression provided. Aborting...'
        return
    }

    $baseDir = Get-BaseDirectory $baseDir

    # Set the regular expression, or use the file name as the default
    $regEx = @{ $true = (Split-Path -Leaf $fileName); $false = $regEx }['' -ne $fileName]
	Write-Verbose "Get-Executable: RegEx is '$regEx'"

    $files = Get-ChildItem -Path $baseDir -Recurse | Where-Object { $_.Name -match $regEx }
	Write-Verbose "Get-Executable: Found '$($files.Count)' file(s) matching '$regEx' in '$baseDir'"

    # Always use the first file found
    if ($files.Count -gt 0) {
		Write-Verbose "Get-Executable: Executable is '$($files[0].FullName)'"

        return $files[0].FullName
    }
    elseif (!$files) {
        return
    }
}