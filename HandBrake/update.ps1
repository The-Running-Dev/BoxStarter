param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\_Scripts\update.begin.ps1')

function global:au_BeforeUpdate {
    $downloader = New-Object System.Net.WebClient
    $downloadedFile = Join-Path $packageDir $Latest.FileName32
    $downloader.DownloadFile($Latest.Url32, $downloadedFile)

    # Create a .ignore file for each found executable
    New-Item "$($downloadedFile).ignore" -ErrorAction SilentlyContinue

    $Latest.Checksum32 = (Get-FileHash $downloadedFile).Hash
}

function global:au_GetLatest {
    $releaseUrl = 'https://handbrake.fr/downloads.php'
    $versionRegEx = 'Current Version: ([0-9\.]+)'
    $downloadUrlPrefix = 'https://handbrake.fr'
    $downloadUrlRegEx = '\.exe'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = [version]([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $partialUrl = $releasePage.Links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand href
    $url = "$downloadUrlPrefix/$partialUrl"

    $fileName = ([regex]::match($url, 'file=(.*)').Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version; FileName32 = $fileName }
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

. (Join-Path $PSScriptRoot '..\_Scripts\update.end.ps1')