param([switch] $force)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://codecguide.com/download_k-lite_codec_pack_mega.htm'
    $downloadUrl = 'http://files2.codecguide.com/K-Lite_Codec_Pack_$($fileVersion)_Mega.exe'
    $versionRegEx = '.*?Version ([0-9\.]+)\ Mega.*'
    $checksumRegEx = '.*<strong>SHA256<\/strong>: ([a-z0-9]+)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = $releasePage.Content -replace $versionRegEx, '$1'
    $fileVersion = $version -replace '\.', ''
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')