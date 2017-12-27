param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://www.filehorse.com/download-flux/'
    $downloadUrl = 'https://justgetflux.com/flux-setup.exe'
    $versionRegEx = '.*f.lux ([0-9\.]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = [regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')