function Uninstall-Packages {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $file
    )

    Write-Message "Uninstalling packages from '$file'..."

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    }

    $command = "choco uninstall ##token## -r --execution-timeout 14400 -y $packagesSource"

    Invoke-Commands $file $command
}