function Enable-WindowsFeatures {
    param(
        [string] $file
    )

    Write-Message "Enabling Windows Features from $file"

    Invoke-Commands $file "choco install ##token## -r -source WindowsFeatures -y"
}