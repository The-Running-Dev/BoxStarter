Import-Module au

$global:stableVersionDownloadUrl = 'https://www.binaryfortress.com/Data/Download/?package=voicebot&log=123'
$global:stableVersionRegEx = '.*VoiceBotSetup-([0-9\.\-]+)\.exe$'

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
  $stableVersionDownloadUrl = ((Get-WebURL -Url $global:stableVersionDownloadUrl).ResponseUri).AbsoluteUri
  $stableVersion = $($stableVersionDownloadUrl -replace $global:stableVersionRegEx, '$1')

  return @{ Url32 = $stableVersionDownloadUrl; Version = $stableVersion }
}

Update-Package -ChecksumFor none