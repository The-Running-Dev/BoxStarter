$installer          = 'ASMedia_USB3.1(v1.16.35.1).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/All/USB/ASMedia_USB3.1(v1.16.35.1).zip'
$checksum           = '38773EF4A60C58F6404343785E628FB9E0604BE7D89D550E47F37C480C1A23E0'
$packageChecksum    = ''
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    executable      = 'Setup.exe'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/S /v/qn'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments