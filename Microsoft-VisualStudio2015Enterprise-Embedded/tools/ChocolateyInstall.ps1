. (Join-Path $env:ChocolateyPackageFolder 'tools\Helpers.ps1')

$packageChecksum    = '871EBBDB1DB77E4A39A00B01B9EE5B92440DC8FCFBC5879D97D581A5251C41CA'
$installerBase      = 'Microsoft Visual Studio 2015 Enterprise'

# The file is defined explictely so the update script can find it and embed it
$arguments          = @{
    file            = 'Microsoft Visual Studio 2015 Enterprise.7z'
    destination     = $env:Temp
    silentArgs      = "/Quiet /NoRestart /NoRefresh /Log $env:Temp\VisualStudio.log /AdminFile $configuration"
    executable      = "$installerBase\vs_enterprise.exe"
    validExitCodes  = @(2147781575, 2147205120)
}

Set-Features $parameters $configurationFile

Install-Package $arguments

Get-ChildItem $env:Temp -Filter $installerBase | Remove-Item -Recurse -Force
