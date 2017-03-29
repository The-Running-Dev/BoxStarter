$installer          = 'Dropbox%2022.4.24%20Offline%20Installer.exe'
$url                = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2022.4.24%20Offline%20Installer.exe'
$checksum           = '37d27d3ebd0426be061495e9efd4d67f7e3dd3b582f89fea6a31b45b3fb9beb0'
$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-CustomPackage @packageArgs

if (Get-Process -Name Dropbox) {
    Stop-Process -processname Dropbox
}
