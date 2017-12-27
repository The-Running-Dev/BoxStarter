param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $versionUrl = 'https://steam.en.softonic.com/'
    $versionRegEx = 'Steam.*<span>([0-9\.]+)</span>'
    $url = 'https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe'

    $versionPage = Invoke-WebRequest -Uri $versionUrl -UseBasicParsing
    $version = ([regex]::match($versionPage.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')