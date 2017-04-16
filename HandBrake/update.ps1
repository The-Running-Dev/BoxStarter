param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_BeforeUpdate {
    $Latest.FileName32 = 'HandBrake-1.0.7-x86_64-Win_GUI.exe'

    $downloadedFile = Join-Path $packageDir $Latest.FileName32
    $downloader = New-Object System.Net.WebClient
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

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')