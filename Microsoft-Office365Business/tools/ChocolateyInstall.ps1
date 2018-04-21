. (Join-Path $env:ChocolateyPackageFolder 'tools\Helpers.ps1')

$parameters = Get-Parameters $env:chocolateyPackageParameters
$defaultConfigurationFile = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$configurationFile = Get-ConfigurationFile $parameters.ConfigurationFile $defaultConfigurationFile

$arguments = @{
    packageName = 'Office Deployment Tool'
    executablePackageName = 'Office Setup Files'
    executable = "$env:Temp\Office\Setup.exe"
    executableArgs = "/download ""$configurationFile"""
    url = 'https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_9119.3601.exe'
    checksum = '1DA31BB6F4BCD487F1DA3BDD1B3E8C0A87877A8EB599FF6DAD39DD2B4D230590'
    silentArgs = "/extract:""$env:Temp\Office"" /log:""$env:Temp\OfficeInstall.log"" /quiet /norestart"
    validExitCodes = @(2147781575, 2147205120)
}

Set-Features $parameters $configurationFile

if (![System.IO.File]::Exists($installer)) {
    Get-SetupFiles $arguments

    # The installer should be the local downloaded setup file
    $installer = $arguments.executable
}

$arguments = @{
    file = $installer
    silentArgs = "/configure ""$configurationFile"""
    validExitCodes = @(2147781575, 2147205120)
}

Install-Package $arguments

if (Test-Path "$env:Temp\Office") {
    Remove-Item -Recurse "$env:Temp\Office"
}
