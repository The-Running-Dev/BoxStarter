Import-Module AU

$getBetaVersion = $false

$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$packagesDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter'
$installersDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter\Installers'

function global:au_BeforeUpdate {
    $downloadFile = Join-Path $currentDir "tools\$([System.IO.Path]::GetFileNameWithoutExtension($Latest.URL32))_x32.exe"
    $file = Join-Path $installersDir $([System.IO.Path]::GetFileName($Latest.Url32))

    Get-RemoteFiles

    Move-Item $downloadFile $file -Force
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
    $stableVersionDownloadUrl = 'https://www.dropbox.com/download?full=1&plat=win'
    $stableVersionRegEx = '.*Dropbox%20([0-9\.]+).*'

    $betaVersionReleasePageUri = 'https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016'
    $betaVersionDownloadUrl = 'https://clientupdates.dropboxstatic.com/client/Dropbox%20$($betaVersion)%20Offline%20Installer.exe'
    $betaVersionRegEx = '.*Beta-Build-([0-9\.\-]+).*'

    if ($getBetaVersion) {
        $betaVersion = ((Get-FirstBetaLink $betaVersionReleasePageUri $betaVersionRegEx) -replace $betaVersionRegEx, '$1') -replace '-', '.'
        $betaVersionDownloadUrl = $ExecutionContext.InvokeCommand.ExpandString($betaVersionDownloadUrl)

        return @{ Url32 = $betaVersionDownloadUrl; Version = $betaVersion }
    }

    $stableVersionDownloadUrl = ((Get-WebURL -Url $stableVersionDownloadUrl).ResponseUri).AbsoluteUri
    $stableVersion = $($stableVersionDownloadUrl -replace $stableVersionRegEx, '$1')

    return @{ Url32 = $stableVersionDownloadUrl; Version = $stableVersion }
}

function Get-FirstBetaLink([string] $uri, [string] $regEx) {
    $html = Invoke-WebRequest -UseBasicParsing -Uri $uri

    return $html.links | Where-Object { $_.href -match $regEx } | Select-Object -First 1
}

Update-Package -ChecksumFor none -NoCheckChocoVersion
Get-ChildItem $currentDir -Filter '*.nupkg' | ForEach-Object { Move-Item $_.FullName $packagesDir -Force }