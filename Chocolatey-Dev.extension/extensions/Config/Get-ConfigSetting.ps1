function Get-ConfigSetting {
    [cmdletbinding()]
    param (
        [parameter(Mandatory = $true)][PSCustomObject] $config,
        [parameter(Mandatory = $true)][string] $key,
        [parameter(Mandatory = $false)][string] $defaultValue = $null
    )

    if ($config.$key) {
        return @{$true = $config.$key; $false = $defaultValue}[$config.$key -ne '']
    }

    return $defaultValue
}