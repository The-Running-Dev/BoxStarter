. (Join-Path $env:ChocolateyPackageFolder 'tools\Helpers.ps1')

$parameters = Get-Parameters $env:chocolateyPackageParameters
$defaultConfigurationFile = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$configurationFile = Get-ConfigurationFile $parameters.ConfigurationFile $defaultConfigurationFile

$arguments = @{
    packageName = 'Office Deployment Tool'
    executablePackageName = 'Office Setup Files'
    executable = "$env:Temp\Office\Setup.exe"
    executableArgs = "/download ""$configurationFile"""
    url = ''
    checksum = ''
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
