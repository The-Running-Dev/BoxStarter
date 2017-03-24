$installer            = 'Acronis True Image 2017.exe'
$installerScript      = Join-Path $env:ChocolateyPackageFolder 'Install.exe'
$defaultSettingsFile  = Join-Path $env:ChocolateyPackageFolder 'Settings.reg'
$parameters           = Get-Parameters $evn:packageParameters
$parameters['file']   = Get-ConfigurationFile $parameters['file'] $defaultSettingsFile
$arguments            = @{
    packageName       = $env:ChocolateyPackageName
    softwareName      = $evn:ChocolateyPackageTitle
    unzipLocation     = $env:ChocolateyPackageFolder
    file              = Join-Path $env:ChocolateyPackageFolder $installer
    fileType          = 'exe'
    validExitCodes    = @(0, 1641, 3010)
}

$installerPath = Get-Installer $arguments

Start-Process $installerPath

# Launch the AutoHotkey script that install the application
Start-Process $installerScript -Wait

Start-Sleep -s 5

Import-RegistryFile $parameters