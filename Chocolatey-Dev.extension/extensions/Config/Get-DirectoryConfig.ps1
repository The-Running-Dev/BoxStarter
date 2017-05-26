function Get-DirectoryConfig {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Container})][string] $path,
        [Parameter(Position = 1)][Hashtable] $baseConfig = $global:config
    )

    $configFile = Join-Path $path $global:configFile

    # No config file found, look for it in the parent directory
    if (!(Test-Path $configFile)) {
        $configFile = Join-Path (Split-Path -Parent $path) $global:configFile
    }

    if (Test-Path $configFile) {
        $dir = Split-Path -Parent $configFile
        $configJson = (Get-Content $configFile -Raw) | ConvertFrom-Json

        $config = $global:config
        $config.artifacts = Get-ConfigSetting $configJson 'artifacts' | Convert-ToFullPath -BasePath $dir
        $defaultFilter = $global:defaultFilter -split ','

        if ($configJson.remote) {
            $config.remote.include = $defaultFilter + (((Get-ConfigSetting $configJson.remote 'include') -replace ' ', '') -Split ',')
            $config.remote.sources = @()

            foreach ($source in $configJson.remote.sources) {
                $config.remote.sources += @{
                    pushTo = Get-ConfigSetting $source 'pushTo' | Convert-ToFullPath -BasePath $dir
                    apiKey = Get-ConfigSetting $source 'apiKey'
                }
            }
        }

        if ($configJson.local) {
            $config.local.include = $defaultFilter + (((Get-ConfigSetting $configJson.local 'include') -replace ' ', '') -Split ',')
            $config.local.sources = @()

            foreach ($source in $configJson.local.sources) {
                $config.local.sources += @{
                    pushTo = Get-ConfigSetting $source 'pushTo' | Convert-ToFullPath -BasePath $dir
                    apiKey = Get-ConfigSetting $source 'apiKey'
                }
            }
        }

        return $config
    }

    return $baseConfig
}