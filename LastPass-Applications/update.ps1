param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://lastpass.com/download'
    $downloadUrl = 'https://download.cloud.lastpass.com/windows_installer/lastappinstall_x64.exe'
    $versionRegEx = '<a id="applications".*?Version ([0-9\.]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = ($releasePage.Content -Replace '[\n\r]', '') -match $versionRegEx | `
        ForEach-Object { $Matches[1] }

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')