function Get-Config() {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $configFile,
        [Parameter(Position = 1, ValueFromPipeline)][string] $environment = '',
        [Parameter(Position = 2, ValueFromPipeline)][string] $versionTag = '',
        [Parameter(Position = 3)][switch] $output
    )

    $configFilePath = (Get-Item $configFile).FullName
    $config = Get-Content $configFile | ConvertFrom-Json
    $configDir = Split-Path $configFilePath -Parent

    Write-Host "Loading config from '$configFilePath'..."

    # No environment or version tag specified as parameters
    # so read them from th config file
    if ((-not $environment) -or (-not $versionTag)) {
        if (-not $environment) {
            $environment = $config.EnvironmentTag
        }

        if (-not $versionTag) {
            $versionTag = $config.VersionTag
        }
    }

    # Setup the environment tag
    if ($environment -match 'Dev|Development') {
        $config.environmentTag = 'dev'
    }
    elseif ($environment -match 'Staging') {
        $config.environmentTag = 'staging'
    }
    elseif ($environment -match 'Prod|Production') {
        $environment = 'production'
        $config.environmentTag = 'prod'
    }

    # If the Environment is not Dev or Development
    # find the appropriate environment config file and ovewrtite the
    # config values with the ones from the environment config file
    if ($environment -and $environment -notmatch 'Dev|Development') {
        $envConfigFile = Join-Path $configDir "$($(Get-Item $configFile).BaseName).$environment.json"
        Write-Host "Using Environment '$environment' with config file '$envConfigFile'"

        $envConfig = Get-Content $envConfigFile | ConvertFrom-Json
        $envConfig | Get-Member -MemberType NoteProperty | ForEach-Object {
            $key = $_.Name
            $value = $($envConfig).$key

            if ($value | Get-Member -MemberType NoteProperty) {
                $value | Get-Member -MemberType NoteProperty | ForEach-Object {
                    $subKey = $_.Name
                    $subValue = $($value).$subKey

                    Write-Host "Overwritting '$subKey' with '$subValue'"
                    $($config).$key.$subKey = $subValue
                }
            }
            else {
                Write-Host "Overwritting '$key' with '$value'"
                $($config).$key = $value
            }
        }
    }

    if ($config.versionTag) {
        $config.versionTag = $versionTag
    }

    # For each property in the config file that doesn't have sub-keys
    # use ExpandString to evaluate any variables in the config file
    $config | Get-Member -MemberType NoteProperty | ForEach-Object {
        $key = $_.Name
        $value = $($config).$key

        if (-not ($value | Get-Member -MemberType NoteProperty)) {
            $value = $value -Replace '\$(\w+)', '$($config.$1)'
            $($config).$key = $ExecutionContext.InvokeCommand.ExpandString($value)
        }
    }

    # For each property in the config file that has sub-keys
    # use ExpandString to evaluate any variables in the config file
    $config | Get-Member -MemberType NoteProperty | ForEach-Object {
        $key = $_.Name
        $value = $($config).$key

        if ($value | Get-Member -MemberType NoteProperty) {
            $value | Get-Member -MemberType NoteProperty | ForEach-Object {
                $subKey = $_.Name
                $subValue = $($value).$subKey

                $subValue = $subValue -Replace '\$(\w+)', '$($config.$1)'
                $($config).$key.$subKey = $ExecutionContext.InvokeCommand.ExpandString($subValue)
            }
        }
    }

    # Re-map any partial parts to full paths
    # Needed because Join-Path doesn't work on non-existant pats
    $config | Get-Member -MemberType NoteProperty | ForEach-Object {
        $key = $_.Name
        $value = $($config).$key

        # If the value starts with .\ or ..\
        if ($value -match '^\.\.\\') {
            $($config).$key = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath((Join-Path $configDir $value))
        }
    }

    if ($output) {
        # Output all the config settings
        $config | Get-Member -MemberType NoteProperty | ForEach-Object {
            $key = $_.Name
            $value = $($config).$key

            if ($value | Get-Member -MemberType NoteProperty) {
                Write-Host "$($_.Name)"

                $value | Get-Member -MemberType NoteProperty | ForEach-Object {
                    $subKey = $_.Name
                    $subValue = $($value).$subKey

                    Write-Host "`t$($subKey): $subValue"
                }
            }
            else {
                Write-Host "$($key): $value"
            }
        }
    }

    return $config
}