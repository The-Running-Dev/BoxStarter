function Get-BaseDirectory([string] $baseDir) {
    if (Test-DirectoryExists $baseDir) {
        return $baseDir
    }

    # Overwrite the base directory with packagesInstallers
    if (Test-DirectoryExists $env:packagesInstallers) {
		Write-Verbose "Get-BaseDirectory: Using 'PackagesInstallers' $($env:packagesInstallers)"
        return $env:packagesInstallers
    }

    # Overwrite the base directory with ChocolateyPackageFolder
    if (Test-DirectoryExists $env:ChocolateyPackageFolder) {
		Write-Verbose "Get-BaseDirectory: Using 'ChocolateyPackageFolder' $($env:ChocolateyPackageFolder)"
        return $env:ChocolateyPackageFolder
    }
}