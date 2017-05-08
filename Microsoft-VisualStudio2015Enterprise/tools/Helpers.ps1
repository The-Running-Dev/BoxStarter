function Set-Features {
    param(
        [PSCustomObject] $parameters,
        [string] $configurationFile
    )

    # If features are passed in through the command line
    if ($parameters.features) {
        [xml] $xml = Get-Content $configurationFile

        Write-Host "Features: $($parameters.features)"

        foreach ($feature in $parameters.features.Split(',')) {
            $node = $xml.DocumentElement.SelectableItemCustomizations.ChildNodes | `
                Where-Object {$_.Id -eq $feature}

            if ($node -ne $null) {
                $node.Selected = "yes"
            }
        }

        $xml.Save($configurationFile)
    }
}