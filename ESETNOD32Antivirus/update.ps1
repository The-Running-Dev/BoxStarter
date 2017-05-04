param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://www.filehorse.com/download-nod32-64/'
    $downloadUrl = 'https://download.eset.com/com/eset/apps/home/eav/windows/latest/eav_nt64_enu.exe'
    $versionRegEx = '.*NOD32 AntiVirus ([0-9\.]+) \(64\-bit\)'

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $releaseUrl
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value) -replace '([0-9\.]+)\..*', '$1'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(file\s*=\s*)('.*')" = "`$1'$($Latest.FileName32)'"
            "(?i)(url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')