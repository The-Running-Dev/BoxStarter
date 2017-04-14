$installer          = 'vcredist_x86.exe'
$url                = 'http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe'
$checksum           = 'A22895E55B26202EAE166838EDBE2EA6AAD00D7EA600C11F8A31EDE5CBCE2048'
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
