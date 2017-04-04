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
    $releasesUrl = 'http://www.filehorse.com/download-vmware-workstation/'
    $downloadUrl = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-$($fileVersion).exe'
    $versionRegEx = '.*VMware Workstation ([0-9\.]+) Build ([0-9]+)'

    $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl
    $versionInfo = [regex]::match($html.Content, $versionRegEx)
    $version = $versionInfo.Groups[1].Value
    $build = $versionInfo.Groups[2].Value

    $fileVersion = "$version-$build"
    $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

    return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion
Get-ChildItem $currentDir -Filter '*.nupkg' | ForEach-Object { Move-Item $_.FullName $packagesDir -Force }