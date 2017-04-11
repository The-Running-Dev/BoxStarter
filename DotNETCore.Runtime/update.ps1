. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.microsoft.com/net/download/core#/runtime'
    $versionRegEx = '.NET Core ([0-9\.]+) runtime \(Current\)'
    $downloadLinkRegEx = '\.exe download'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $downloadLink = $downloadPage.Links | Where-Object outerHTML -match $downloadLinkRegEx | Select-Object -First 1 -Skip 3 -Expand href

    $version = [regex]::match($downloadPage.Content, $versionRegEx).Groups[1].Value
    $url = ((Get-WebURL -Url $downloadLink).ResponseUri).AbsoluteUri

    return @{ Url32 = $url; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion