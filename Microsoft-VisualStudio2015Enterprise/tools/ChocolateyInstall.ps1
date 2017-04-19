$packageChecksum        = 'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855EF124C6BC9F5AA29929994BE1C670AE971FF2EF97CD4B22D6A09C724C0E6617D1DE3DD8F24639548191B20551C796B16A8EE570D361EAB878C1624DB186027E3'
$defaultConfiguration   = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$parameters             = Get-Parameters $env:chocolateyPackageParameters
$configuration          = Get-ConfigurationFile $parameters['Configuration'] $defaultConfiguration
$arguments              = @{
    file                = 'en_visual_studio_enterprise_2015_with_update_3_x86_x64_web_installer_8922986.exe'
    url                 = $url
    checksum            = 'https://download.my.visualstudio.com/pr/en_visual_studio_enterprise_2015_with_update_3_x86_x64_web_installer_8922986.exe?t=76368aea-bbfd-4488-825c-921f8913f18e&e=1492142627&h=85b56a83096ad6300bf670cf6c2bedc8&su=1'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = "/Quiet /NoRestart /NoRefresh /Log $env:Temp\VisualStudio.log /AdminFile $configuration"
    validExitCodes      = @(2147781575, 2147205120)
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

Install-Package $arguments
