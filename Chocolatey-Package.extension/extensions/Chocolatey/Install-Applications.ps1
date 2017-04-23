function Install-Applications {
    param(
        [string] $file
    )

    Write-Message "Install-Applications: From $file"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    }

    $command = "choco install ##token## -r --execution-timeout 14400 -y $packagesSource"

    Write-Message "Install-Applications: $command"

    Invoke-Commands $file $command
}