Import-Module AU -Force

$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$packagesDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter'
$installersDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter\Installers'

$global:downloadFile = 'jre-$($fileVersion)-windows-i586.exe'
$global:downloadFile64 = 'jre-$($fileVersion)-windows-x64.exe'

function global:au_BeforeUpdate {
    $file = Join-Path $installersDir $downloadFile
    $file64 = Join-Path $installersDir $downloadFile64

    $downloadFilePath = (Join-Path $currentDir $global:downloadFile)
    $downloadFile64Path = (Join-Path $currentDir $global:downloadFile64)

    $client = New-Object System.Net.WebClient
    $client.DownloadFile($Latest.Url32, $downloadFilePath)
    $client.DownloadFile($Latest.Url64, $downloadFile64Path)

    Move-Item $downloadFilePath $file -Force
    Move-Item $downloadFile64Path $file64 -Force

    $Latest.ChecksumType32 = 'sha256'
    $Latest.ChecksumType64 = 'sha256'
    $Latest.Checksum32 = (Get-FileHash $file -Algorithm $Latest.ChecksumType32 | ForEach Hash).ToLowerInvariant()
    $Latest.Checksum64 = (Get-FileHash $file64 -Algorithm $Latest.ChecksumType64 | ForEach Hash).ToLowerInvariant()
}

function global:au_AfterUpdate {
    Get-ChildItem $currentDir -Filter '*.nupkg' | ForEach-Object { Move-Item $_.FullName $packagesDir -Force }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]x86Installer\s*=\s*)('.*')" = "`$1'$($global:downloadFile)'"
            "(?i)(^[$]x64Installer\s*=\s*)('.*')" = "`$1'$($global:downloadFile64)'"
            "(?i)(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.Url64)'"
            "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $downloadEndPointUrl = 'https://www.java.com/en/download/manual.jsp'
    $versionRegEx = 'Version ([0-9]+) Update ([0-9]+)'
    $donwloadUrlRegEx = 'Download Java software for Windows Offline'
    $donwloadUrlRegEx64 = 'Download Java software for Windows \(64\-Bit\)'

    $downloadPage = Invoke-WebRequest -UseBasicParsing -Uri $downloadEndPointUrl
    $versionInfo = $downloadPage.Content -match $versionRegEx

    if ($matches) {
        $major = $matches[1]
        $build = $matches[2]
    }

    $version = @{ $true = "$major.0.$build"; $false = "$major.$build"}[1 -eq $version.length]

    $html = Invoke-WebRequest -UseBasicParsing -Uri $downloadEndPointUrl
    $downloadUrl = $html.links | Where-Object { $_.title -match $donwloadUrlRegEx } | Select-Object -First 1 -Expand href
    $downloadUrl64 = $html.links | Where-Object { $_.title -match $donwloadUrlRegEx64 } | Select-Object -First 1 -Expand href

    $fileVersion = "$($major)u$($build)"
    $global:downloadFile = $ExecutionContext.InvokeCommand.ExpandString($global:downloadFile)
    $global:downloadFile64 = $ExecutionContext.InvokeCommand.ExpandString($global:downloadFile64)

    return @{ Url32 = $downloadUrl; Url64 = $downloadUrl64; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion