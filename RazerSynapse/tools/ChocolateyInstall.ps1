$installer          = 'Razer_Synapse_Framework_V2.20.17.302.exe'
$url                = 'http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Framework_V2.20.17.302.exe'
$checksum           = 'AF4C3B0607AACEF6D4496F9B8E4F37F2A9D01C965435A708C5D8FAFF7BB26435'
$installerScript    = Join-Path $packageDir 'Install.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes  = @(0, 1641, 3010)
}

Start-Process $installerScript

Start-Sleep 10

Install-CustomPackage $arguments
