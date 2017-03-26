$installer          = 'Razer_Synapse_Framework_V2.20.15.1104.exe'
$url                = 'http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Framework_V2.20.15.1104.exe'
$checksum           = 'A568786FEE965F8AC2B8F9942521E1D2B08EFFC566D8471917C2233FEA49700F'
$installerScript    = Join-Path $packageDir 'Install.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
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