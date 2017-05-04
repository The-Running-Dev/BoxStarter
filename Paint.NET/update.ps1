param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'https://www.getpaint.net/index.html'
    $versionRegEx = 'paint\.net\s+([0-9\.]+)'
    $urlString = 'https://www.dotpdn.com/files/paint.net.$version.install.zip'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $url = $ExecutionContext.InvokeCommand.ExpandString($urlString)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version; }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(executable\s*=\s*)('.*')" = "`$1'$([System.IO.Path]::GetFileNameWithoutExtension($Latest.Url32)).exe'"
        }
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')