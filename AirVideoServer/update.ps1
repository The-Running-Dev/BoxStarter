param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadEndPointUrl = 'http://download.inmethod.com/current-win'
    $versionRegEx = 'AirVideoServerHD-([0-9\.]+).*'

    $url = ((Get-WebURL -Url $downloadEndPointUrl).ResponseUri).AbsoluteUri
    $version = [regex]::match($url, $versionRegEx).Groups[1].Value

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')