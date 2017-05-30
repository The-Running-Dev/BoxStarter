function Install-Packages {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $configFile
    )

    Write-Message "Installing packages from '$configFile'..."

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    }

    $command = "choco install ##token## -r --execution-timeout 14400 -y $packagesSource"

    Invoke-Commands $configFile $command
}