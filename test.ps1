Import-Module (Join-Path $PSScriptRoot 'build-helpers.psm1') -Force

#$c = Get-Configuration $PSScriptRoot
#write-host $($c['D:\Dropbox\Projects\BoxStarter'].local | out-string)
#write-host $($c.remote.include | out-string)
#write-host $($c.local.include | out-string)
#Get-ChildItem -Recurse -Include $c.local.include

$c = @{}

# Get all the configuration files starting at the base directory
$configFiles = Get-ChildItem -Path $baseDir -Recurse -File -Filter 'config.json'

foreach ($f in $configFiles) {
    $config = $global:config
    $dir = Split-Path -Parent $f.FullName

    $configJson = (Get-Content $f.FullName -Raw) | ConvertFrom-Json

    #write-host $configJson.local.source

    $config.artifacts = Get-ConfigurationSetting $configJson 'artifacts' | Convert-ToFullPath -BasePath $dir
    $config.remote.source = Get-ConfigurationSetting $configJson.remote 'source' | Convert-ToFullPath -BasePath $dir
    $config.remote.apiKey = Get-ConfigurationSetting $configJson.remote 'apiKey'
    $config.remote.include = $global:config.remote.include + ((Get-ConfigurationSetting $configJson.remote 'include') -replace ' ', '' | Split-String ',')
    $config.local.source = Get-ConfigurationSetting $configJson.local 'source' | Convert-ToFullPath -BasePath $dir
    $config.local.apiKey = Get-ConfigurationSetting $configJson.local 'apiKey'
    $config.local.include = $global:config.local.include + ((Get-ConfigurationSetting $configJson.local 'include') -replace ' ', '' | Split-String ',')

    write-host "$dir,  $($config.local.source)"
    $c.Add($dir, $config)
    write-host "Keys: $($c.keys | out-string)"
    write-host "Values: $($c.values.local.source | out-string)"
}

#write-host $($c['D:\Dropbox\Projects\BoxStarter'].local | out-string)