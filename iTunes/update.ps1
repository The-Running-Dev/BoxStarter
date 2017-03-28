Import-Module AU

$releasesUrl = 'https://www.apple.com/itunes/download/'

function global:au_BeforeUpdate() {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
}

function global:au_BeforeUpdate {
  $checksumType = 'sha256'
  $Latest.ChecksumType32 = $Latest.ChecksumType64 = $checksumType

  $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32 -Algorithm $checksumType
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
  $downloadPage = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing

  $downloadPage.Content -match "\<iframe src=`"([^`"]+)`"[^\>\/]+title=`"Please select a download" | Out-Null
  $iframeLink = $Matches[1]
  $Matches = $null

  $downloadPage = Invoke-WebRequest -Uri $iframeLink -UseBasicParsing
  $downloadPage.Content -match "[`"'](https:\/\/[^`"']+iTunes6464Setup\.exe)[`"']" | Out-Null
  $downloadUrl = $Matches[1]
  $Matches = $null

  $re = "[`"']iTunes ([\d\.]+) for Windows"
  $downloadPage.Content -match $re
  if ($Matches) {
    $version = $Matches[1]
  }

  return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none

Update-Package -ChecksumFor none -NoCheckChocoVersion