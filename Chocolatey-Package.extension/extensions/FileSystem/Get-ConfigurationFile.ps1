function Get-ConfigurationFile() {
    param(
        [Parameter(Position = 0, ValueFromPipeline)][string] $configuration,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)][string] $defaultConfiguration
    )

    if ([System.IO.File]::Exists($configuration)) {
        return $configuration
    }

    if (($configuration -as [System.URI]).AbsoluteURI -ne $null) {
        $localConfiguration = Join-Path $env:Temp (Split-Path -leaf $defaultConfiguration)

        if (Test-Path $localConfiguration) {
            Remove-Item $localConfiguration
        }

        Get-ChocolateyWebFile 'ConfigurationFile' $localConfiguration $configuration | Out-Null

        return $localConfiguration
    }

    return $defaultConfiguration
}