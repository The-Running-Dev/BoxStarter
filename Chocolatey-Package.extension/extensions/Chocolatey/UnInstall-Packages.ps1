function Uninstall-Packages {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $packagesFile
    )

    Write-Message "Uninstalling packages from $packagesFile"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    }

    $command = "choco uninstall ##token## -r --execution-timeout 14400 -y $packagesSource"

    Invoke-Commands $packagesFile $command
}