function Get-Installer {
    param(
        [Hashtable] $arguments
    )

    $url = Get-Argument $arguments 'url'
	Write-Verbose "Get-Installer: Url is '$url'"

	$arguments['unzipLocation'] = Get-Argument $arguments 'unzipLocation' $env:ChocolateyPackageFolder
	Write-Verbose "Get-Installer: Unzip Location is '$($arguments['unzipLocation'])'"

    $arguments['file'] = Get-Argument $arguments 'file' (Join-Path $arguments['unzipLocation'] ([System.IO.Path]::GetFileName($url)))
	Write-Verbose "Get-Installer: File is '$($arguments['file'])'"

    $arguments['executable'] = Get-Argument $arguments 'executable' ([System.IO.Path]::GetFileName($arguments['file']))
	Write-Verbose "Get-Installer: Executable is '$($arguments['executable'])'"

    $arguments['executableRegEx'] = Get-Argument $arguments 'executableRegEx'
	Write-Verbose "Get-Installer: Executable Reg Ex is '$($arguments['executableRegEx'])'"

    $extension = Get-FileExtension $arguments['file']
	Write-Verbose "Get-Installer: Extension is '$extension'"

    if ($extension -eq '.zip') {
        return Get-InstallerFromZip $arguments
    }
    elseif ($extension -eq '.iso') {
        return Get-InstallerFromIso $arguments
    }

    $installer = Get-Executable $arguments['unzipLocation'] $arguments['executable'] $arguments['executableRegEx']

    if (Test-FileExists $installer) {
		Write-Verbose "Get-Installer: Installer is '$installer'"
        return $installer
    }

    return Get-InstallerFromWeb $arguments
}