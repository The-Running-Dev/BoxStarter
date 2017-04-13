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