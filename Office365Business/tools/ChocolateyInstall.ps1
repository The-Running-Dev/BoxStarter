$script                     = $MyInvocation.MyCommand.Definition
$packageName                = 'Office365Business'
$packageDir                 = GetParentDirectory $script
$deploymentTool             = Join-Path (GetParentDirectory $script) 'officedeploymenttool_7614-3602.exe'
$defaultConfigurationFile   = Join-Path (GetParentDirectory $script) 'Configuration.xml'
$defaultConfigurationFile32 = Join-Path (GetParentDirectory $script) 'Configuration32.xml'

$packageArgs                = @{
    packageName             = 'Office325DeploymentTool'
    unzipLocation           = (GetCurrentDirectory $script)
    fileType                = 'exe'
    url                     = 'https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_7614-3602.exe'
    checksum                = 'CB9B41ABF4C3D67D082BA534F757A0C84F7CA4AF89D77590CC58290B7C875F5E'
    checksumType            = 'sha256'
    softwareName            = 'Office365Business*'
    silentArgs              = "/extract:$env:Temp\Office /log:$env:Temp\OfficeInstall.log /quiet /norestart"
    validExitCodes          = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

$defaultConfigurationFile = if (IsSystem32Bit) { $defaultConfigurationFile32 } else { $defaultConfigurationFile }
$packageParameters = ParseParameters $env:chocolateyPackageParameters
$configurationFile = GetConfigurationFile $packageParameters['ConfigurationFile'] $defaultConfigurationFile
$setupPath = PrepareInstaller $packageParameters

if (!([System.IO.File]::Exists($setupPath))) {
    # Download the deployment tool
    Install-ChocolateyPackage @packageArgs

    # Use the deployment tool to download the installer
    $packageArgs['packageName'] = 'Office365BusinessInstaller'
    $packageArgs['file'] = "$env:Temp\Office\Setup.exe"
    $packageArgs['silentArgs'] = "/download $configurationFile $env:temp\Office\setup.exe"
    Install-ChocolateyInstallPackage @packageArgs

    $packageArgs['file'] = "$env:Temp\Office\Setup.exe"
}

$packageArgs['packageName'] = $packageName
$packageArgs['silentArgs'] = "/configure $configurationFile"
Install $packageArgs

if (Test-Path "$env:temp\office") {
    Remove-Item -Recurse "$env:temp\Office"
}