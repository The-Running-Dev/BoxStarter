function Enable-WindowsFeatures([string] $file)
{
    Write-Host "Enabling Windows Features from $file"

    Invoke-Commands $file "choco install ##token## -r -source WindowsFeatures -y"
}