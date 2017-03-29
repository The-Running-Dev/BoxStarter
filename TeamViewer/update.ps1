Import-Module AU

$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$packagesDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter'
$installersDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter\Installers'

function global:au_BeforeUpdate {
    $downloadFile = Join-Path $currentDir "tools\$([System.IO.Path]::GetFileNameWithoutExtension($Latest.URL32))_x32.exe"
    $file = Join-Path $installersDir $([System.IO.Path]::GetFileName($Latest.Url32))

    Get-RemoteFiles

    Move-Item $downloadFile $file -Force

    [Version]$productVersion = Get-CustomVersion $file

    if ($productVersion -gt [version]$Latest.Version) {
        throw "New version is released, but not yet updated on filehorse"
    }
    elseif ($productVersion -lt [version]$Latest.Version) {
        throw "Filehorse shows a newer version than what is available officially"
    }
}

function global:au_AfterUpdate {
    Get-ChildItem $currentDir -Filter '*.nupkg' | ForEach-Object { Move-Item $_.FullName $packagesDir -Force }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]installer\s*=\s*)('.*')" = "`$1'$([System.IO.Path]::GetFileName($Latest.URL32))'"
            "(?i)(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $releasesUrl = 'http://www.filehorse.com/download-teamviewer/'
    $downloadUrl = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    $versionRegEx = '.TeamViewer ([0-9\.]+)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $version = ([regex]::match($html.Content, $versionRegEx).Groups[1].Value)

    return @{ Url32 = $downloadUrl; Version = $version }
}

function Get-CustomVersion([string] $file) {
    return [System.Diagnostics.FileVersionInfo]::GetVersionInfo($file) | % {
        [Version](($_.FileMajorPart, $_.FileMinorPart, $_.FileBuildPart) -join ".")
    }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion