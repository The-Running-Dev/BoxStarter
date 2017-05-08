function Get-ConfigSetting {
    [cmdletbinding()]
    param (
        [parameter(Position = 0, Mandatory = $true)][PSCustomObject] $config,
        [parameter(Position = 1, Mandatory = $true)][string] $key,
        [parameter(Position = 2, Mandatory = $false)][string] $defaultValue = $null
    )

    if ($config.$key) {
        return @{$true = $config.$key; $false = $defaultValue}[$config.$key -ne '']
    }

    return $defaultValue
}