function Read-ConfigFile {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $configFile,
        [Parameter(Position = 1)][PSCustomObject] $baseConfig = $global:config
    )

    $basePath = Split-Path -Parent $configFile
    $configJson = (Get-Content $configFile -Raw) | ConvertFrom-Json

    $config = $baseConfig

    if ($configJson.artifacts) {
        $config.artifacts = Get-ConfigSetting $configJson 'artifacts' | Resolve-PathSafe -BasePath $basePath
    }

    $defaultFilter = $global:defaultFilter -split ','

    if ($configJson.remote) {
        $config.remote.include = $defaultFilter + (((Get-ConfigSetting $configJson.remote 'include') -replace ' ', '') -Split ',')
        $config.remote.sources = @()

        foreach ($source in $configJson.remote.sources) {
            $config.remote.sources += @{
                source = Get-ConfigSetting $source 'source' | Resolve-PathSafe -BasePath $basePath
                apiKey = Get-ConfigSetting $source 'apiKey'
            }
        }
    }

    if ($configJson.local) {
        $config.local.include = $defaultFilter + (((Get-ConfigSetting $configJson.local 'include') -replace ' ', '') -Split ',')
        $config.local.sources = @()

        foreach ($source in $configJson.local.sources) {
            $config.local.sources += @{
                source = Get-ConfigSetting $source 'source' | Resolve-PathSafe -BasePath $basePath
                apiKey = Get-ConfigSetting $source 'apiKey'
            }
        }
    }

    return $config
}