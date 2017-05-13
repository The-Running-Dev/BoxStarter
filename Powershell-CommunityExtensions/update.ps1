param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $url = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pscx&DownloadId=923562&FileTime=130585918034470000&Build=21050'
    $version = '3.2.0'
    $fileName32 = 'Pscx-3.2.0.msi'
    $fileType = 'msi'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version; FileName32 = $fileName32; FileType = $FileType }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(file\s*=\s*)('.*')"     = "`$1'$($Latest.FileName32)'"
            "(?i)(url\s*=\s*)('.*')"      = "`$1'$($Latest.Url32)'"
            "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')