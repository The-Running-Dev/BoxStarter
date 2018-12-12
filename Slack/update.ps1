param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://slack.com/downloads/windows'
    $downloadUrl = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    $versionRegEx = '.*Ver.* ([\d]+\.[\d\.]+)'

    $downloadPage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing -MaximumRedirection 1
    $version = ([regex]::match($downloadPage.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')