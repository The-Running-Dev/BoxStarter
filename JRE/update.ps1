param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

$global:downloadFile = 'jre-$($fileVersion)-windows-i586.exe'
$global:downloadFile64 = 'jre-$($fileVersion)-windows-x64.exe'
$installersPath = Join-Path $packageDir '..\..\..\BoxStarter\Installers' -Resolve

function global:au_BeforeUpdate {
    $existingPackageInstaller = Join-Path $installersPath $global:downloadFile
    $existingPackageInstaller64 = Join-Path $installersPath $global:downloadFile64
    $client = New-Object System.Net.WebClient

    if (!(Test-Path $existingPackageInstaller)) {
        $file = Join-Path $packageDir $downloadFile
        $downloadFilePath = (Join-Path $packageDir $global:downloadFile)
        $client.DownloadFile($Latest.Url32, $downloadFilePath)
        Move-Item $downloadFilePath $file -Force

        $Latest.ChecksumType32 = 'sha256'
        $Latest.Checksum32 = (Get-FileHash $file).Hash
    }
    else {
        Copy-Item $existingPackageInstaller $packageDir -Force
        Copy-Item "$($existingPackageInstaller).ignore" $packageDir -Force

        $Latest.Checksum32 = (Get-FileHash $existingPackageInstaller).Hash
    }

    if (!(Test-Path $existingPackageInstaller64)) {
        $file64 = Join-Path $packageDir $downloadFile64
        $downloadFile64Path = (Join-Path $packageDir $global:downloadFile64)
        $client.DownloadFile($Latest.Url64, $downloadFile64Path)
        Move-Item $downloadFile64Path $file64 -Force

        $Latest.ChecksumType64 = 'sha256'
        $Latest.Checksum64 = (Get-FileHash $file64).Hash
    }
    else {
        Copy-Item $existingPackageInstaller64 $packageDir -Force
        Copy-Item "$($existingPackageInstaller).ignore" $existingPackageInstaller64 -Force

        $Latest.Checksum64 = (Get-FileHash $existingPackageInstaller64).Hash
    }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]x86Installer\s*=\s*)('.*')" = "`$1'$($global:downloadFile)'"
            "(?i)(file\s*=\s*)('.*')" = "`$1'$($global:downloadFile64)'"
            "(?i)(url\s*=\s*)('.*')" = "`$1'$($Latest.Url32)'"
            "(?i)(url64\s*=\s*)('.*')" = "`$1'$($Latest.Url64)'"
            "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(?i)(checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
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

    $releasePage = Invoke-WebRequest -UseBasicParsing -Uri $downloadEndPointUrl
    $downloadUrl = $releasePage.links | Where-Object { $_.title -match $donwloadUrlRegEx } | Select-Object -First 1 -Expand href
    $downloadUrl64 = $releasePage.links | Where-Object { $_.title -match $donwloadUrlRegEx64 } | Select-Object -First 1 -Expand href

    $fileVersion = "$($major)u$($build)"
    $global:downloadFile = $ExecutionContext.InvokeCommand.ExpandString($global:downloadFile)
    $global:downloadFile64 = $ExecutionContext.InvokeCommand.ExpandString($global:downloadFile64)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $downloadUrl; Url64 = $downloadUrl64; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')