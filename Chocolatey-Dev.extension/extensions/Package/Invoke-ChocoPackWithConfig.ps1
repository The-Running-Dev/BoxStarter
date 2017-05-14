function Invoke-ChocoPackWithConfig {
    param (
        [Parameter(Position = 0, Mandatory = $true)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Position = 1, Mandatory = $false)][String] $searchTerm = '',
        [Parameter(Position = 2, Mandatory = $false)][String] $sourceType = 'local',
        [Parameter(Position = 3, Mandatory = $false)][switch] $force
    )

    $searchTerm = Get-SearchTerm $searchTerm
    $baseConfig = Get-DirectoryConfig $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName
        $directoryConfig = Get-DirectoryConfig $currentDir $baseConfig
        $config = Get-SourceConfig $directoryConfig $sourceType
        $includeFilter = $config.include

        Set-Location $currentDir

        New-ChocoPackageWithConfig $p.FullName $includeFilter $directoryConfig.artifacts $force

        Set-Location $baseDir
    }
}