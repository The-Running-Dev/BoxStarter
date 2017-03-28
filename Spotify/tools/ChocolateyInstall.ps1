$installer          = 'SpotifyFullSetup.exe'
$url                = 'https://download.spotify.com/SpotifyFullSetup.exe'
$checksum           = '56acd50df0d3e4706abb04f8952536dbb8fab627a54df53019e47884af024d0d'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/silent'
    validExitCodes  = @(0, 1641, 3010)
}

Install-WithScheduledTask $arguments

$done = $false
do {
    if (Get-Process Spotify -ErrorAction SilentlyContinue) {
        Stop-Process -name Spotify
        $done = $true
    }

    Start-Sleep -s 10

}
until ($done)
