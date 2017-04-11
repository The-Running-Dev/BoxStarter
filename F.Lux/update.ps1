. (Join-Path $PSScriptRoot '..\update.common.ps1')

function global:au_GetLatest {
    $releasesUrl = 'http://www.filehorse.com/download-flux/'
    $downloadUrl = 'https://justgetflux.com/flux-setup.exe'
    $versionRegEx = '.*f.lux ([0-9\.]+)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl

    $version = [regex]::match($html.Content, $versionRegEx).Groups[1].Value

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion