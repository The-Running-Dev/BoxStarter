function Disable-WindowsFeatures {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $configFile
    )

    Write-Message "Disabling Windows Features from '$configFile'..."

    Invoke-Commands $configFile "choco uninstall ##token## -r -source WindowsFeatures -y"
}