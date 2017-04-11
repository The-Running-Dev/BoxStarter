. (Join-Path $PSScriptRoot '..\update.common.ps1')

function global:au_GetLatest {
    $releasesUrl = 'http://www.filehorse.com/download-nod32-64/'
    $downloadUrl = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    $versionRegEx = '.*NOD32 AntiVirus ([0-9\.]+) \(64\-bit\)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl

    $version = ([regex]::match($html.Content, $versionRegEx).Groups[1].Value) -replace '([0-9\.]+)\..*', '$1'

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion