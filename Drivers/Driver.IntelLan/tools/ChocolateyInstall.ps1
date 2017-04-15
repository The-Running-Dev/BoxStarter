$installer          = 'Lan(v20.2_PV_v2).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/LAN/Lan(v20.2_PV_v2).zip'
$checksum           = '7D33EABB49D2B91D5883EFDC899E4636A33DC868199B96CBEFE7D068646ACE6E'
$packageChecksum    = ''
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    setup           = 'LAN(v20.2_PV_v2)\APPS\PROSETDX\Winx64\PROSETDX.msi'
    fileType        = 'msi'
    checksumType    = 'sha256'
    silentArgs      = '/S /v/qn'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments