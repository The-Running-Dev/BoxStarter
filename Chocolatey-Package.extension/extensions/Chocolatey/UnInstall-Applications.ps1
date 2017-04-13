function UnInstall-Applications([string] $file)
{
    Write-Host "Uninstalling Applications from $file"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    }

    Invoke-Commands $file "choco uninstall ##token## -r --execution-timeout 14400 -y $packagesSource"
}