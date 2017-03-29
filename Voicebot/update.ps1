Import-Module AU
Import-Module (Join-Path (Split-Path -Parent (Split-Path -parent $MyInvocation.MyCommand.Definition)) 'build-helpers.psm1')

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
            "(?i)(^[$]installer\s*=\s*)('.*')" = "`$1'$([System.IO.Path]::GetFileName($Latest.URL32))'"
            "(?i)(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $downloadEndPoint = 'https://www.binaryfortress.com/Data/Download/?package=voicebot&log=123'
    $versionRegEx = 'VoiceBotSetup\-([0-9\.\-]+)\.exe$'

    $downloadUrl = ((Get-WebURL -Url $downloadEndPoint).ResponseUri).AbsoluteUri
    $version = ([regex]::match($downloadUrl, $versionRegEx).Groups[1].Value)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion