function Invoke-ChocoPackWithConfig {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local',
        [Parameter(Mandatory = $false, Position = 3)][switch] $force
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