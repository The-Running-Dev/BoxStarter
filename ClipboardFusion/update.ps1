Import-Module au

$global:stableVersionDownloadUri = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&log=104'
$global:stableVersionRegEx = '.*ClipboardFusionSetup-([0-9\.\-]+)\.exe$'

$global:getBetaVersion = $true
$global:betaVersionDownloadUri = 'https://www.binaryfortress.com/Data/Download/?package=clipboardfusion&beta=1&log=104'
$global:betaVersionRegEx = '.*ClipboardFusionSetup-([0-9\.\-]+)-Beta([0-9]+).*'

function au_BeforeUpdate() {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
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
  if ($global:getBetaVersion) {
    $betaVersionDownloadUri = ((Get-WebURL -Url $global:betaVersionDownloadUri).ResponseUri).AbsoluteUri
    $betaVersion = $($betaVersionDownloadUri -replace $global:betaVersionRegEx, '$1.$2')

    return @{ Url32 = $betaVersionDownloadUri; Version = $betaVersion }
  }

  $stableVersionDownloadUri = ((Get-WebURL -Url $global:stableVersionDownloadUri).ResponseUri).AbsoluteUri
  $stableVersion = $($stableVersionDownloadUri -replace $global:stableVersionRegEx, '$1')

  return @{ Url32 = $stableVersionDownloadUri; Version = $stableVersion }
}

update -ChecksumFor none