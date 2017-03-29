$installer          = 'ClipboardFusionSetup-5.0-Beta4.exe'
$url                = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.0-Beta4.exe'
$checksum           = '8bc560e85a844f6fd0412e6bd43028f30cb6acd14afe4092f02c70072e69bea9'
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
