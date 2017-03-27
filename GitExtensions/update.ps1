Import-Module AU
Import-Module (Join-Path .. 'build-helpers.psm1') -Force

$global:gitHubRepository = 'gitextensions/gitextensions'
$global:downloadUrlRegEx = '.*SetupComplete\.msi$'

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
  $release = GitHubVersion $global:gitHubRepository $global:downloadUrlRegEx

  return @{ Url32 = $release.DownloadUrl; Version = $release.Version }
}

update -ChecksumFor none