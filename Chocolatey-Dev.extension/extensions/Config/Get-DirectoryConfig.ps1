function Get-DirectoryConfig {
    param (
        [Parameter(Mandatory = $true, Position = 0)][ValidateNotNullOrEmpty()][String] $path,
        [Parameter(Mandatory = $false, Position = 1)][Hashtable] $baseConfig = $global:config
    )

    $configFile = Join-Path $path $global:configFile

    if (!(Test-Path $configFile)) {
        $configFile = Join-Path (Split-Path -Parent $path) $global:configFile
    }

    if (Test-Path $configFile) {
        $dir = Split-Path -Parent $configFile
        $configJson = (Get-Content $configFile -Raw) | ConvertFrom-Json

        $config = $global:config
        $config.artifacts = Get-ConfigSetting $configJson 'artifacts' | Convert-ToFullPath -BasePath $dir

        if ($configJson.remote) {
            $config.remote.source = Get-ConfigSetting $configJson.remote 'source' | Convert-ToFullPath -BasePath $dir
            $config.remote.apiKey = Get-ConfigSetting $configJson.remote 'apiKey'
            $config.remote.include = $global:config.remote.include + ((Get-ConfigSetting $configJson.remote 'include') -replace ' ', '' | Split-String ',')
        }

        if ($configJson.local) {
            $config.local.source = Get-ConfigSetting $configJson.local 'source' | Convert-ToFullPath -BasePath $dir
            $config.local.apiKey = Get-ConfigSetting $configJson.local 'apiKey'
            $config.local.include = $global:config.local.include + ((Get-ConfigSetting $configJson.local 'include') -replace ' ', '' | Split-String ',')
        }

        return $config
    }

    return $baseConfig
}