$installer          = 'Dropbox 23.4.19 Offline Installer.exe'
$url                = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2023.4.19%20Offline%20Installer.exe'
$checksum           = 'B0EF95B799DE483559FCD40871186A5E0C56C9971B99D17D51BA21DCB22FC8B2'
$arguments        	= @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-CustomPackage $arguments

if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {
    Stop-Process -processname Dropbox
}
