$defaultConfigurationFile   = Join-Path $env:ChocolateyPackageFolder 'Configuration.xml'
$arguments                  = @{
    packageName             = 'OfficeDeploymentTool'
    file                    = 'officedeploymenttool_8008-3601.exe'
    url                     = 'https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_8008-3601.exe'
    checksum                = 'A7F8CD73AD61EDDB42303E7D2A0D4F4080B8330267E7B6AD63C17F12926F04DD'
    silentArgs              = "/extract:$env:Temp\Office /log:$env:Temp\OfficeInstall.log /quiet /norestart"
    validExitCodes          = @(2147781575, 2147205120)
}

$parameters = Get-Parameters $env:chocolateyPackageParameters
$configurationFile = Get-ConfigurationFile $parameters['ConfigurationFile'] $defaultConfigurationFile
$installerPath = Get-Installer $parameters

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
    $arguments['packageName'] = 'Office365BusinessInstaller'
    $arguments['file'] = "$env:Temp\Office\Setup.exe"
    $arguments['silentArgs'] = "/download ""$configurationFile"" $env:Temp\$env:ChocolateyPackageName\Setup.exe"

    Install-ChocolateyInstallPackage @arguments

    $arguments['file'] = "$env:Temp\$env:ChocolateyPackageName\Setup.exe"
}

$arguments['packageName'] = $env:ChocolateyPackageName
$arguments['silentArgs'] = "/configure ""$configurationFile"""

Install-CustomPackage $arguments

if (Test-Path "$env:Temp\$env:ChocolateyPackageName") {
    Remove-Item -Recurse "$env:Temp\$env:ChocolateyPackageName"
}
