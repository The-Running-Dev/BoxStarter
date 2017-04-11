. (Join-Path $PSScriptRoot '..\update.common.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://slack.com/downloads/windows'
    $downloadUrl = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    $versionRegEx = '.*Version ([\d]+\.[\d\.]+)'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $version = $downloadPage.Content -match $versionRegEx

    if ($matches) {
        $version = $matches[1]
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion