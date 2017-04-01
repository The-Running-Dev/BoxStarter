$installer            = 'LogFusionSetup-5.2.1.exe'
$url                  = 'https://www.binaryfortress.com/Data/Download/?package=logfusion&log=117'
$checksum             = '5EBAA729F3763F618961FD406ED5BD1828FEE656E2D330B76B699084623BE902'
$arguments            = @{
    packageName       = $env:ChocolateyPackageName
    softwareName      = $env:ChocolateyPackageTitle
    unzipLocation     = $env:ChocolateyPackageFolder
    file              = Join-Path $env:ChocolateyPackageFolder $installer
    url               = $url
    checksum          = $checksum
    fileType          = 'exe'
    checksumType      = 'sha256'
    silentArgs        = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
    validExitCodes    = @(0, 1641, 3010)
}

Install-CustomPackage $arguments