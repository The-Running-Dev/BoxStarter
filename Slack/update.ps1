param([switch] $force)

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'https://slack.com/downloads/windows'
    $downloadUrl = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    $versionRegEx = '.*Version ([\d]+\.[\d\.]+)'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $version = ([regex]::match($downloadPage.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')