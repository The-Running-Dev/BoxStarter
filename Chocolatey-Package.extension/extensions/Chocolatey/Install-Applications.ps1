function Install-Applications([string] $file)
{
    Write-Host "Installing Applications from $file"

    if ($env:packagesSource) {
        $packagesSource = "-s ""$env:packagesSource;Chocolatey"""
    }

    Invoke-Commands $file "choco install ##token## -r --execution-timeout 14400 -y $packagesSource"
}