function Get-BaseDirectory([string] $baseDir) {
    $originalBase = $baseDir

    # Overwrite the base directory with ChocolateyPackageFolder,
    # if ChocolateyPackageFolder exists
    if (Test-DirectoryExists $env:ChocolateyPackageFolder) {
		Write-Verbose "Get-BaseDirectory: 'ChocolateyPackageFolder' is $($env:ChocolateyPackageFolder)"
        $baseDir = $env:ChocolateyPackageFolder
    }

    # Overwrite the base directory with packagesInstallers,
    # if packagesInstallers exists
    if (Test-DirectoryExists $env:packagesInstallers) {
		Write-Verbose "Get-BaseDirectory: 'packagesInstallers' is $($env:packagesInstallers)"
        $baseDir = $env:packagesInstallers
    }

	Write-Verbose "Get-BaseDirectory: Base directory is '$baseDir'"
    return $baseDir
}