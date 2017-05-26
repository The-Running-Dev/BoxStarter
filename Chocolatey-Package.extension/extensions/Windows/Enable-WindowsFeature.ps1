function Enable-WindowsFeature {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $featureName
    )

    $feature = Get-WindowsOptionalFeature -FeatureName $featureName -Online

    if ($feature.State -ne 'Enabled') {
        Write-Message "Enabling $featureName"

        Enable-WindowsOptionalFeature -FeatureName $featureName -Online -All
    }
    else {
        Write-Message "$featureName Enabled...Skipping"
    }
}