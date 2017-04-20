. (Join-Path $env:ChocolateyPackageFolder 'tools\Helpers.ps1')

$parameters = Get-Parameters $env:chocolateyPackageParameters
$defaultConfigurationFile   = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$configurationFile = Get-ConfigurationFile $parameters.ConfigurationFile $defaultConfigurationFile

$installer                  = $parameters.file
$arguments                  = @{
    packageName             = 'Office Deployment Tool'
    file                    = 'officedeploymenttool_8008-3601.exe'
    executablePackageName   = 'Office Setup Files'
    executable              = "$env:Temp\Office\Setup.exe"
    executableArgs          = "/download ""$configurationFile"""
    url                     = 'https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_8008-3601.exe'
    checksum                = 'A7F8CD73AD61EDDB42303E7D2A0D4F4080B8330267E7B6AD63C17F12926F04DD'
    silentArgs              = "/extract:""$env:Temp\Office"" /log:""$env:Temp\OfficeInstall.log"" /quiet /norestart"
    validExitCodes          = @(2147781575, 2147205120)
}

Set-Features $parameters

if (![System.IO.File]::Exists($installer)) {
    Get-SetupFiles $arguments

    # The installer should be the local downloaded setup file
    $installer = $arguments.executable
}

$arguments                  = @{
    file                    = $installer
    silentArgs              = "/configure ""$configurationFile"""
    validExitCodes          = @(2147781575, 2147205120)
}

Install-Package $arguments

if (Test-Path "$env:Temp\Office") {
    Remove-Item -Recurse "$env:Temp\Office"
}
