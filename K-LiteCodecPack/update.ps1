. (Join-Path $PSScriptRoot '..\update.common.ps1')

function global:au_GetLatest {
    $releasesUrl = 'http://codecguide.com/download_k-lite_codec_pack_mega.htm'
    $downloadUrl = 'http://files2.codecguide.com/K-Lite_Codec_Pack_$($fileVersion)_Mega.exe'
    $versionRegEx = '.*Version ([0-9\.]+) Mega'
    $checksumRegEx = '.*<strong>SHA256<\/strong>: ([a-z0-9]+)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl

    $version = [regex]::match($html.Content, $versionRegEx).Groups[1].Value
    #$Latest.checksum = [regex]::match($html.Content, $checksumRegEx).Groups[1].Value

    $fileVersion = $version -replace '\.', ''
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion