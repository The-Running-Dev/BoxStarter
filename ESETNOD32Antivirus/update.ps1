param([switch] $force)

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'http://www.filehorse.com/download-nod32-64/'
    $downloadUrl = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    $versionRegEx = '.*NOD32 AntiVirus ([0-9\.]+) \(64\-bit\)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $version = ([regex]::match($html.Content, $versionRegEx).Groups[1].Value) -replace '([0-9\.]+)\..*', '$1'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')