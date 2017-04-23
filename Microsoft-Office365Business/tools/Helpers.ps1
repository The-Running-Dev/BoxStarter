function Set-Features {
    param(
        [PSCustomObject] $parameters
    )

    # If exclude features were passed in through the command line
    if ($parameters.excludefeatures) {
        Write-Host "Excluding: $($parameters.excludefeatures)"

        [xml] $xml = Get-Content $configurationFile
        $features = $parameters.excludefeatures.Split(',')

        foreach ($feature in $features) {
            $excludeFeature = $xml.CreateElement('ExcludeApp')
            $excludeFeature.SetAttribute('ID', $feature)

            $office = $xml.SelectSingleNode("Configuration/Add/Product[@ID=""O365ProPlusRetail""]")
            $office.AppendChild($excludeFeature)
        }

        $xml.Save($configurationFile)
    }
}

function Get-SetupFiles {
     param(
        [PSCustomObject] $arguments
    )

    Install-Package $arguments
}