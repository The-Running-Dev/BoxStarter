$script                     = $MyInvocation.MyCommand.Definition
$packageName                = 'Office365Business'
$packageDir                 = Get-ParentDirectory $script
$deploymentTool             = Join-Path (Get-ParentDirectory $script) 'officedeploymenttool_7614-3602.exe'
$defaultConfigurationFile   = Join-Path (Get-ParentDirectory $script) 'Configuration.xml'
$defaultConfigurationFile32 = Join-Path (Get-ParentDirectory $script) 'Configuration32.xml'
$packageArgs                = @{
    packageName             = 'Office325DeploymentTool'
    unzipLocation           = (Get-CurrentDirectory $script)
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
$parameters = Get-Parameters $env:chocolateyPackageParameters
$configurationFile = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$installerPath = Get-InstallerPath $parameters

# If exclude features were passed in through the command line
if ($parameters['excludefeatures']) {
    Write-Host "Excluding: $($parameters['excludefeatures'])"

    [xml] $xml = Get-Content $configurationFile
    $features = $parameters['excludefeatures'].Split(',')

    foreach ($feature in $features)
    {
        $excludeFeature = $xml.CreateElement('ExcludeApp')
        $excludeFeature.SetAttribute('ID', $feature)

        $office = $xml.SelectSingleNode("Configuration/Add/Product[@ID=""O365ProPlusRetail""]")
        $office.AppendChild($excludeFeature)
    }

    $xml.Save($configurationFile)
}

if (!([System.IO.File]::Exists($installerPath))) {
    # Use the deployment tool to download the installer
    $packageArgs['packageName'] = 'Office365BusinessInstaller'
    $packageArgs['file'] = "$env:Temp\Office\Setup.exe"
    $packageArgs['silentArgs'] = "/download ""$configurationFile"" $env:temp\Office\Setup.exe"
    Install-ChocolateyInstallPackage @packageArgs

    $packageArgs['file'] = "$env:Temp\Office\Setup.exe"
}

$packageArgs['packageName'] = $packageName
$packageArgs['silentArgs'] = "/configure ""$configurationFile"""
Install-LocalOrRemote $packageArgs

if (Test-Path "$env:temp\office") {
    Remove-Item -Recurse "$env:temp\Office"
}