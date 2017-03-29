$installer          = 'Razer_Synapse_Framework_V2.20.17.302.exe'
$url                = 'http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Framework_V2.20.17.302.exe'
$checksum           = 'af4c3b0607aacef6d4496f9b8e4f37f2a9d01c965435a708c5d8faff7bb26435'
$installerScript    = Join-Path $packageDir 'Install.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = ''
    silentArgs      = '/s'
    validExitCodes  = @(0, 1641, 3010)
}

Start-Process $installerScript

Start-Sleep 10

Install-CustomPackage $arguments
