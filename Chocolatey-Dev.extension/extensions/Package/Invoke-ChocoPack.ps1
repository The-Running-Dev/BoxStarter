function Invoke-ChocoPack {
    [CmdletBinding()]
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Container})][string] $baseDir,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][String] $searchTerm,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][String] $sourceType = 'local',
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][switch] $force
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

        New-ChocoPackage $p.FullName $includeFilter $directoryConfig.artifacts $force

        Set-Location $baseDir
    }
}