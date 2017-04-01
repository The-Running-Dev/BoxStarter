$installer          = 'wpilauncher.exe'
$url                = 'https://go.microsoft.com/fwlink/?LinkId=255386'
$checksum           = '5CA3400C444CF4B970833E0986656E907A318DBA4F85D37E70512D67B3087710'
$arguments = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    validExitCodes  = @(0, 1641, 3010)
}

Install-CustomPackage $arguments

Start-Sleep -s 5

if (Get-Process -Name WebPlatformInstaller) {
    Stop-Process -processname WebPlatformInstaller
}
