$installer          = 'WebStorm-2016.3.4.exe'
$url                = 'https://download.jetbrains.com/webstorm/WebStorm-2016.3.4.exe'
$checksum           = '962F0BBF94A76DC79DD2D9C1B898ABE9F9BB3201CB71CDB25D6731290D1955B9'
$arguments = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/S'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments