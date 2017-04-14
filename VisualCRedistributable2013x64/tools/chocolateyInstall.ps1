$installer          = 'vcredist_x64.exe'
$url                = 'http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe'
$checksum           = 'E554425243E3E8CA1CD5FE550DB41E6FA58A007C74FAD400274B128452F38FB8'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/Q /norestart'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments
