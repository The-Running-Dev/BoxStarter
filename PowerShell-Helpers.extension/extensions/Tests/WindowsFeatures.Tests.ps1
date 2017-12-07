<#
function Enable-WindowsFeatures([string] $file)
{
    Write-Host "Enabling Windows Features from $file"

    Invoke-Commands $file "choco install ##token## -r -source WindowsFeatures -y"
}

function Disable-WindowsFeatures([string] $file)
{   
    Write-Host "Disabling Windows Features from $file"

    Invoke-Commands $file "choco uninstall ##token## -r -source WindowsFeatures -y"
}

function Enable-WindowsFeature([string] $featureName) {
    $feature = Get-WindowsOptionalFeature -FeatureName $featureName -Online

    if ($feature.State -ne 'Enabled') {
        Write-Host "Enabling $featureName"

        Enable-WindowsOptionalFeature -FeatureName $featureName -Online -All
    }
    else {
        Write-Host "$featureName Enabled...Skipping"
    }
}

Export-ModuleMember *
#>