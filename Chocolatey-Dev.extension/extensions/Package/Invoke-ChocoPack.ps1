function Invoke-ChocoPack {
    [CmdletBinding()]
    param (
        [parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Container})][string] $baseDir,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][String] $searchTerm,
        [Parameter(Position = 2, ValueFromPipelineByPropertyName)][switch] $remote,
        [Parameter(Position = 3, ValueFromPipelineByPropertyName)][switch] $force
    )

    $searchTerm = Get-SearchTerm $searchTerm
    $packages = Get-Packages $baseDir $searchTerm '*.nuspec'

    foreach ($p in $packages) {
        $currentDir = Split-Path -Parent $p.FullName
        $config = Get-DirectoryConfig $currentDir $baseConfig
        $sourceConfig = @{$true = $config.remote; $false = $config.local}[$remote -eq $true]

        Push-Location $currentDir
        New-ChocoPackage $p.FullName $config.artifacts $sourceConfig.include $force
        Pop-Location
    }
}