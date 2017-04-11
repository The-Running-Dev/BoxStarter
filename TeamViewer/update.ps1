. (Join-Path $PSScriptRoot '..\Build\update.common.ps1')

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