param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

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

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')