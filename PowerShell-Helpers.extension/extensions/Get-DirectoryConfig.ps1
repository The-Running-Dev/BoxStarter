function Get-DirectoryConfig {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Container})][string] $baseDir,
        [Parameter(Position = 1)][PSCustomObject] $baseConfig = $global:config
    )

    # Get the parent config file
    $parentConfigFile = Join-Path (Split-Path -Parent $baseDir) $global:configFile
    if (Test-Path $parentConfigFile) {
        $baseConfig = Read-ConfigFile $parentConfigFile
    }

    $configFile = Join-Path $baseDir $global:configFile
    if (Test-Path $configFile) {
        $config = Read-ConfigFile $configFile $baseConfig

        return $config
    }

    return $baseConfig
}