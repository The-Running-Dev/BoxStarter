$installer          = 'RapidStorage(v14.8.0.1042_PV).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/SATA/RapidStorage(v14.8.0.1042_PV).zip'
$checksum           = '40F07F0173889651B3D1E72BC657E1C2EAA85744B4D0AC23926957FF63548E5E'
$packageChecksum    = '062375887F5006B7EDC33CA7C5A122324EB09D0D1B8AB8270E11974869126D9940F07F0173889651B3D1E72BC657E1C2EAA85744B4D0AC23926957FF63548E5E'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    executable      = 'RapidStorage(v14.8.0.1042_PV)\SetupRST.exe'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '-s -overwrite'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
