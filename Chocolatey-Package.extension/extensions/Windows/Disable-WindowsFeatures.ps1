function Disable-WindowsFeatures([string] $file)
{
    Write-Host "Disabling Windows Features from $file"

    Invoke-Commands $file "choco uninstall ##token## -r -source WindowsFeatures -y"
}