function Enable-WindowsFeatures {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $configFile
    )

    Write-Message "Enabling Windows Features from $configFile"

    Invoke-Commands $configFile "choco install ##token## -r -source WindowsFeatures -y"
}