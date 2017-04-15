$installer          = 'INF(v10.1.2.10).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/INF/INF(v10.1.2.10).zip'
$checksum           = 'D1E9A7E0B170C4B819E1223B956E47B37CF7F2728ECE52C43A3D3D5ED91CD7FA'
$packageChecksum    = ''
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    executable      = 'INF(v10.1.2.10)\SetupChipset.exe'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/S /v/qn'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments