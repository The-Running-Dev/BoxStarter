. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://www.filehorse.com/download-google-chrome-64/'
    $downloadUrl = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    $versionRegEx = '.*Google Chrome ([0-9\.]+) \(64\-bit\)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($html.Content, $versionRegEx).Groups[1].Value

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion