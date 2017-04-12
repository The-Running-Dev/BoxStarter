. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://octopus.com/downloads'
    $downloadLinkRegEx = 'OctopusTools\.([0-9\.]+)\.zip'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $url = $downloadPage.Links | Where-Object href -match $downloadLinkRegEx | Select-Object -First 1 -Expand href
    $version = [regex]::match($url, $downloadLinkRegEx).Groups[1].Value

    return @{ Url32 = $url; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion