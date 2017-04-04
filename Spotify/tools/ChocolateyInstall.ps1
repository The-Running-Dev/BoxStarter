$installer          = 'SpotifyFullSetup.exe'
$url                = 'https://download.spotify.com/SpotifyFullSetup.exe'
$checksum           = '041625B142EED7A89708D19DCD9785BD812A0EB9E6D9D4A06697F898B705BD6C'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $env:ChocolateyPackageTitle
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
