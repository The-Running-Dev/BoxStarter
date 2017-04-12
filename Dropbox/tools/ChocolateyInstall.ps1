$installer          = 'Dropbox 23.4.18 Offline Installer.exe'
$url                = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2023.4.18%20Offline%20Installer.exe'
$checksum           = 'C6D521B7A8DA60B358CCAB02A4F663F5175E5B0D0241197A6177BBF7ECEA2E67'
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
