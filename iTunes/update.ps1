param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.filehorse.com/download-itunes-64/'
    $downloadUrl = 'https://www.apple.com/itunes/download/win64'
    $versionRegEx = '.*iTunes ([0-9\.]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = $releasePage.Content -match $versionRegEx | ForEach-Object { $matches[1] }

    $url = Get-RedirectUrl $downloadUrl

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')