function Disable-WindowsFeatures {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $configFile
    )

    Write-Message "Disabling Windows Features from $configFile"

    Invoke-Commands $configFile "choco uninstall ##token## -r -source WindowsFeatures -y"
}