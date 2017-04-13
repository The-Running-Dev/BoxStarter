param([switch] $force)

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

$releasesUrl = 'https://www.xyplorer.com/download.php'
$versionRegEx = '([0-9\.]+), released'
$downloadUrl = 'https://www.xyplorer.com/download/xyplorer_full_noinstall.zip'

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $version = [version]([regex]::match($html.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')