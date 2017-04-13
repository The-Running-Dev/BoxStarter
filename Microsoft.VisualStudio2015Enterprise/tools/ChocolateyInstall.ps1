$installer              = 'en_visual_studio_enterprise_2015_with_update_3_x86_x64_web_installer_8922986.exe'
$url                    = 'https://download.my.visualstudio.com/pr/en_visual_studio_enterprise_2015_with_update_3_x86_x64_web_installer_8922986.exe?t=76368aea-bbfd-4488-825c-921f8913f18e&e=1492142627&h=85b56a83096ad6300bf670cf6c2bedc8&su=1'
$checksum               = ''
$defaultConfiguration   = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$parameters             = Get-Parameters $env:chocolateyPackageParameters
$configuration          = Get-ConfigurationFile $parameters['Configuration'] $defaultConfiguration
$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = $env:ChocolateyPackageTitle
    unzipLocation       = $env:ChocolateyPackageFolder
    file                = Join-Path $env:ChocolateyPackageFolder $installer
    url                 = $url
    checksum            = $checksum
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = "/Quiet /NoRestart /NoRefresh /Log $env:Temp\VisualStudio.log /AdminFile $configuration"
    validExitCodes      = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

# If features were passed in through the command line
if ($parameters['features']) {
    $features = $parameters.Split(',')
    [xml]$xml = Get-Content $configuration

    foreach ($feature in $features)
    {
        $node = $xml.DocumentElement.SelectableItemCustomizations.ChildNodes | ? {$_.Id -eq $feature}

        if ($node -ne $null)
        {
            $node.Selected = "yes"
        }
    }

    $xml.Save($configuration)
}

Install-CustomPackage $arguments