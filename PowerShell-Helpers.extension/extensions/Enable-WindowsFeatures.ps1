function Enable-WindowsFeatures {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $configFile
    )

    Write-Message "Enabling Windows Features from '$configFile'..."

    Invoke-Commands $configFile "choco install ##token## -r -source WindowsFeatures -y"
}