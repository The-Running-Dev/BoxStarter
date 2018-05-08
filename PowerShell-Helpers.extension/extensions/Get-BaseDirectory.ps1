function Get-BaseDirectory {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $baseDir
    )

    if (Test-DirectoryExists $baseDir) {
        return $baseDir
    }

    # Overwrite the base directory with installers
    if (Test-DirectoryExists $env:installers) {
        Write-Message "Get-BaseDirectory: Using 'Installers' $($env:installers)"
        return $env:installers
    }

    # Overwrite the base directory with ChocolateyPackageFolder
    if (Test-DirectoryExists $env:ChocolateyPackageFolder) {
        Write-Message "Get-BaseDirectory: Using 'ChocolateyPackageFolder' $($env:ChocolateyPackageFolder)"
        return $env:ChocolateyPackageFolder
    }
}