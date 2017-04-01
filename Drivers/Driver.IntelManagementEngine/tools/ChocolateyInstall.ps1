$installer          = 'ME(v11.0.4.1186_MEI).zip'
$url                = 'http://asrock.pc.cdn.bitgravity.com/Drivers/Intel/Others/ME(v11.0.4.1186_MEI).zip'
$checksum           = '06F32B8994158FD3674DAAD67E93B612ED4162426D660F9A1EDAF1D93224E380'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    executable      = 'ME(v11.0.4.1186_MEI)\MEISetup.exe'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '-s -overwrite -drvonly'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments