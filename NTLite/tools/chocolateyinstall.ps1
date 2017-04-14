$installer          = 'NTLite_setup_x64.exe'
$url                = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe'
$checksum           = '17C4B88846BBFD2CA22D983C03475E60A2D36FBDD12A8EDCF1DD767846CFF689'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
