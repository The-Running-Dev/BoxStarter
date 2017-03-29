Import-Module AU

$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$packagesDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter'
$installersDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter\Installers'

function global:au_BeforeUpdate {
    $downloadFile = Join-Path $currentDir "tools\$([System.IO.Path]::GetFileNameWithoutExtension($Latest.URL32))_x32.exe"
$file = Join-Path $installersDir $([System.IO.Path]::GetFileName($Latest.Url32))

    Get-RemoteFiles

    Move-Item $downloadFile $file -Force
}

function global:au_AfterUpdate {
    Get-ChildItem $currentDir -Filter '*.nupkg' | ForEach-Object { Move-Item $_.FullName $packagesDir -Force }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]installer\s*=\s*)('.*')" = "`$1'$([System.IO.Path]::GetFileName($Latest.Url32))'"
            "(?i)(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $releasesUrl = 'https://www.apple.com/itunes/download/'
    $downloadPage = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing

    $downloadPage.Content -match "\<iframe src=`"([^`"]+)`"[^\>\/]+title=`"Please select a download" | Out-Null
    $iframeLink = $Matches[1]
    $matches = $null

    $downloadPage = Invoke-WebRequest -Uri $iframeLink -UseBasicParsing
    $downloadPage.Content -match "[`"'](https:\/\/[^`"']+iTunes6464Setup\.exe)[`"']" | Out-Null
    $downloadUrl = $Matches[1]
    $matches = $null

    $re = "[`"']iTunes ([\d\.]+) for Windows"
    $downloadPage.Content -match $re

    if ($matches) {
        $version = $Matches[1]
    }

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion