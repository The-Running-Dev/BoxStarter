function Install-CustomPackage() {
    param(
        [Hashtable] $arguments
    )

	$unzipOnly = Get-Argument $arguments 'unzipOnly'

    try {
        $arguments['file'] = Get-Installer $arguments
    }
    catch {
		Write-Host $_.Exception.ToString()
	}

    if (Test-FileExists $arguments['file']) {
        Install-ChocolateyInstallPackage @arguments

        CleanUp
    }
    elseif (!$unzipOnly) {
        CleanUp

		Write-Verbose 'Install-CustomPackage: No installer or url provided. Aborting...'
        throw 'No installer or url provided. Aborting...'
    }
}