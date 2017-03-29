Import-Module AU

$productName = 'DataGrip'
$updatesUri = 'https://www.jetbrains.com/updates/updates.xml'
$downloadUrl = 'https://download.jetbrains.com/datagrip/datagrip-$($version).exe'

$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$downloadFile = Join-Path $currentDir "tools\$([System.IO.Path]::GetFileNameWithoutExtension($Latest.URL32))_x32.exe"
$packagesDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter'
$installersDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter\Installers'
$file = Join-Path $installersDir $([System.IO.Path]::GetFileName($Latest.Url32))

function global:au_BeforeUpdate {
    Get-RemoteFiles

    Move-Item $downloadFile $file -Force

    #$checksumString = (New-Object System.Net.WebClient).DownloadString("$($Latest.Url32).sha256")
    #$Latest.Checksum32 = $checksumString -replace '\s+.*', ''

    $Latest.ChecksumType32 = 'sha256'
    $Latest.Checksum32 = (Get-FileHash $file -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash).ToLowerInvariant()
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
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    [xml] $updates = (New-Object System.Net.WebClient).DownloadString($updatesUri)
    $versionInfo = $updates.products.product `
    | ? { $_.name -eq $productName } `
    | % { $_.channel } `
    | % { $_.build } `
    | Sort-Object { [version] $_.fullNumber } `
    | Select-Object -Last 1

    $version = $versionInfo.Version

    if ($versionInfo.ReleaseDate) {
        $fullVersionNumber = "$($versionInfo.Version).$($versionInfo.ReleaseDate)"
    }
    else {
        $fullVersionNumber = "$($versionInfo.Version).0.0"
    }

    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $fullVersionNumber }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion