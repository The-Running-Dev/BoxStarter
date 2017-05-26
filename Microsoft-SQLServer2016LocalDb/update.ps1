param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $fileName = 'SqlLocalDB.msi'
    $version = '14.0.17099.0'

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Version = $version; FileName32 = $fileName }
}


function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(file\s*=\s*)('.*')"      = "`$1'$($Latest.FileName32)'"
            "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')