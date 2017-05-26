. (Join-Path $env:ChocolateyPackageFolder 'tools\Helpers.ps1')

$packageChecksum            = '42BD8BE2EA0E87C239610FED4FCC24D0B65711181E760CC326942B1078E7CB9D0A1B8D1768490C2F45E2DE7735A59712B2E48C6AFEAE368C1D32D2A245862D1C5EC1DF5BF165DBE513E4E54436D7BD77BEF321AEAD07B11D7DBBEACD07B7EA67'
$defaultConfigurationFile   = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$parameters                 = Get-Parameters $env:chocolateyPackageParameters
$configurationFile          = Get-ConfigurationFile $parameters['Configuration'] $defaultConfigurationFile
$arguments                  = @{
    url                     = 'https://download.my.visualstudio.com/pr/en_visual_studio_enterprise_2015_with_update_3_x86_x64_web_installer_8922986.exe?t=da3749e0-d090-49b5-98d2-399aa43565d2&e=1494202187&h=a5bc8a9169826e69a6065ae7ec6971d7&su=1'
    checksum                = 'D970DFE1230A8E46B2543C60EA468663AE1511C2043A0B9714F99BF1A1BF35FB'
    silentArgs              = "/Quiet /NoRestart /NoRefresh /Log $env:Temp\VisualStudio.log /AdminFile $configuration"
    validExitCodes          = @(2147781575, 2147205120)
}

Set-Features $parameters $configurationFile

Install-Package $arguments
