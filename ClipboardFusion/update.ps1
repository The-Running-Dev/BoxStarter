Import-Module AU

$stableVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104'
$stableVersionRegEx = '.*ClipboardFusionSetup-([0-9\.\-]+)\.exe$'

$getBetaVersion = $true
$betaVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&beta=1&log=104'
$betaVersionRegEx = '.*ClipboardFusionSetup-([0-9\.\-]+)-Beta([0-9]+).*'

$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$downloadFile = Join-Path $currentDir "tools\$([System.IO.Path]::GetFileNameWithoutExtension($Latest.URL32))_x32.exe"
$packagesDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter'
$installersDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter\Installers'
$file = Join-Path $installersDir $([System.IO.Path]::GetFileName($Latest.Url32))

function global:au_BeforeUpdate {
    Get-RemoteFiles

    Move-Item $downloadFile $file -Force

    $Latest.ChecksumType32 = 'sha256'
    $Latest.Checksum32 = (Get-FileHash $file -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash).ToLowerInvariant()
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
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  if ($getBetaVersion) {
    $betaVersionDownloadUrl = ((Get-WebURL -Url $betaVersionDownloadUrl).ResponseUri).AbsoluteUri
    $betaVersion = $($betaVersionDownloadUrl -replace $betaVersionRegEx, '$1.$2')

    return @{ Url32 = $betaVersionDownloadUrl; Version = $betaVersion }
  }

  $stableVersionDownloadUrl = ((Get-WebURL -Url $stableVersionDownloadUrl).ResponseUri).AbsoluteUri
  $stableVersion = $($stableVersionDownloadUrl -replace $stableVersionRegEx, '$1')

  return @{ Url32 = $stableVersionDownloadUrl; Version = $stableVersion }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion