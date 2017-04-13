function Invoke-ChocoPackWithConfig {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $baseDir,
        [Parameter(Mandatory = $false, Position = 1)][String] $searchTerm = '',
        [Parameter(Mandatory = $false, Position = 2)][String] $sourceType = 'local',
        [Parameter(Mandatory = $false, Position = 3)][switch] $force
    )

    $baseConfig = Get-DirectoryConfig $baseDir
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName
        $config = Get-DirectoryConfig $currentDir $baseConfig
        $sourceConfig = Get-SourceConfig $config $sourceType

        Set-Location $currentDir
        New-ChocoPackageWithConfig $p.FullName $sourceConfig $config.artifacts $force
        Set-Location $baseDir
    }
}