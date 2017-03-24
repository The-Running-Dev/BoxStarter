$installer          = 'SpotifyFullSetup.exe'
$url                = 'https://download.spotify.com/SpotifyFullSetup.exe'
$checksum           = 'E69C3B92A6FBFEB8A43C5D66512DEB9F47EFADD57490E51658C4F066864FDE37'
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