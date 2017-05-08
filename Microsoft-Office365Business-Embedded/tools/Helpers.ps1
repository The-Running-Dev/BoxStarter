function Set-Features {
    param(
        [PSCustomObject] $parameters,
        [string] $configurationFile
    )

    # If exclude features were passed in through the command line
    if ($parameters.excludefeatures) {
        [xml] $xml = Get-Content $configurationFile

        Write-Host "Excluding: $($parameters.excludefeatures)"

        foreach ($feature in $parameters.excludefeatures.Split(',')) {
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