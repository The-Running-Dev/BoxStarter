param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_BeforeUpdate {
    $downloader = New-Object System.Net.WebClient

    $downloadedFile = Join-Path $packageDir $Latest.FileName32
    $downloader.DownloadFile($Latest.Url32, $downloadedFile)

    $downloadedFileCLI = Join-Path $packageDir $Latest.FileNameCLI
    $downloader.DownloadFile($Latest.UrlCLI, $downloadedFileCLI)

    # Create a .ignore file for each found executable
    New-Item "$($downloadedFile).ignore" -ErrorAction SilentlyContinue

    $Latest.Checksum32 = (Get-FileHash $downloadedFile).Hash
    $Latest.ChecksumCLI = (Get-FileHash $downloadedFileCLI).Hash
}

function global:au_GetLatest {
    $releaseUrl = 'https://handbrake.fr/downloads.php'
    $releaseUrlCLI = 'https://handbrake.fr/downloads2.php'
    $versionRegEx = 'Current Version: ([0-9\.]+)'
    $downloadUrlPrefix = 'https://handbrake.fr'
    $downloadUrlRegEx = '\.exe'
    $downloadUrlCLIRegEx = '\.zip'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = [version]([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)
    $partialUrl = $releasePage.Links | Where-Object href -match $downloadUrlRegEx | Select-Object -First 1 -Expand href
    $url = "$downloadUrlPrefix/$partialUrl"

    $releasePageCLI = Invoke-WebRequest -Uri $releaseUrlCLI -UseBasicParsing
    $partialUrl = $releasePageCLI.Links | Where-Object href -match $downloadUrlCLIRegEx | Select-Object -First 1 -Expand href
    $urlCLI = "$downloadUrlPrefix/$partialUrl"

    $fileName32 = ([regex]::match($url, 'file=(.*)').Groups[1].Value)
    $fileNameCLI = ([regex]::match($urlCLI, 'file=(.*)').Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{
        Version = $version
        FileName32 = $fileName32
        Url32 = $url
        FileNameCLI = $fileNameCLI
        UrlCLI = $urlCLI
    }
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