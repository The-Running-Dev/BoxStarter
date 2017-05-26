function Install-Packages {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $file
    )

    Write-Message "Installing packages from '$file'..."

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    }

    $command = "choco install ##token## -r --execution-timeout 14400 -y $packagesSource"

    Invoke-Commands $packagesFile $command
}