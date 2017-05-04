param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_BeforeUpdate {
    $downloader = New-Object System.Net.WebClient
    $downloadedFile = Join-Path $packageDir $Latest.FileName32
    $downloader.DownloadFile($Latest.Url32, $downloadedFile)

    $Latest.Checksum32 = (Get-FileHash $downloadedFile).Hash
}

function global:au_GetLatest {
    $releaseUrl = 'https://handbrake.fr/downloads2.php'
    $versionRegEx = 'Current Version: ([0-9\.]+)'
    $downloadUrlPrefix = 'https://handbrake.fr'
    $downloadUrlRegEx = '\.zip'

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

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')