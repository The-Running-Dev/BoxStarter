$installer          = 'ClipboardFusionSetup-5.0-Beta4.exe'
$url                = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.0-Beta4.exe'
$checksum           = '732A157BD32C1B7679103FD59CC07D60E251354ED000E082113D60BEEE8C1F56'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-LocalOrRemote $arguments
