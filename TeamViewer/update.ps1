param([switch] $force, [switch] $push)

$originalLocation = Get-Location
$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $releaseUrl = 'http://www.filehorse.com/download-teamviewer/'
    $downloadUrl = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    $versionRegEx = '.TeamViewer ([0-9\.]+)'

    $releasePage = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
    $version = ([regex]::match($releasePage.Content, $versionRegEx).Groups[1].Value)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

function Get-CustomVersion([string] $file) {
    return [System.Diagnostics.FileVersionInfo]::GetVersionInfo($file) | % {
        [Version](($_.FileMajorPart, $_.FileMinorPart, $_.FileBuildPart) -join ".")
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')