param([switch] $force)

. (Join-Path $PSScriptRoot '..\Build\update.begin.ps1')

function global:au_GetLatest {
    $releasesUrl = 'http://www.filehorse.com/download-teamviewer/'
    $downloadUrl = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    $versionRegEx = '.TeamViewer ([0-9\.]+)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $version = ([regex]::match($html.Content, $versionRegEx).Groups[1].Value)

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

. (Join-Path $PSScriptRoot '..\Build\update.end.ps1')