function Get-ConfigSetting {
    [cmdletbinding()]
    param (
        [parameter(Position = 0, Mandatory)][ValidateNotNullOrEmpty()][PSCustomObject] $config,
        [parameter(Position = 1, Mandatory)][ValidateNotNullOrEmpty()][string] $key,
        [parameter(Position = 2)][string] $defaultValue = $null
    )

    if ($config.$key) {
        return @{$true = $config.$key; $false = $defaultValue}[$config.$key -ne '']
    }

    return $defaultValue
}