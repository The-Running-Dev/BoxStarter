function Get-BaseDirectory {
    param(
        [string] $baseDir
    )

    if (Test-DirectoryExists $baseDir) {
        return $baseDir
    }

    # Overwrite the base directory with packagesInstallers
    if (Test-DirectoryExists $env:packagesInstallers) {
		Write-Message "Get-BaseDirectory: Using 'PackagesInstallers' $($env:packagesInstallers)"
        return $env:packagesInstallers
    }

    # Overwrite the base directory with ChocolateyPackageFolder
    if (Test-DirectoryExists $env:ChocolateyPackageFolder) {
		Write-Message "Get-BaseDirectory: Using 'ChocolateyPackageFolder' $($env:ChocolateyPackageFolder)"
        return $env:ChocolateyPackageFolder
    }
}