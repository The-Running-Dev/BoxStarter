function Get-InstallerFromZip([Hashtable] $arguments) {
    $file = $arguments['file']
    $executable = $arguments['executable']
    $executableRegEx = $arguments['executableRegEx']
    $unzipLocation = $arguments['unzipLocation']

    if (Test-FileExists $file) {
        # We don't care abuot the return of the unzip
        Get-ChocolateyUnzip -FileFullPath $file -Destination $unzipLocation -Force
    }
    elseif ($arguments['url']) {
		Write-Verbose "Get-InstallerFromZip: Calling 'Install-ChocolateyZipPackage'"
        Install-ChocolateyZipPackage @arguments
    }

	$installer = Get-Executable $extractLocation $executable $executableRegEx
	Write-Verbose "Get-InstallerFromZip: Installer is '$installer'"

	return $installer
}