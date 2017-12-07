function Uninstall-Applications {
    param(
        [string] $file
    )

    Write-Message "Uninstall-Applications: From $file"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    }

    $command = "choco uninstall ##token## -r --execution-timeout 14400 -y $packagesSource"

    Write-Message "Uninstall-Applications: $command"

    Invoke-Commands $file $command
}