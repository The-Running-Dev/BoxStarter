$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Import-Module AU
Import-Module (Join-Path (Split-Path -Parent $currentDir)  'build-helpers.psm1') -Force

$gitHubRepository = 'gitextensions/gitextensions'
$downloadUrlRegEx = '.*SetupComplete\.msi$'

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
  $release = Get-GitHubVersion $gitHubRepository $downloadUrlRegEx

  return @{ Url32 = $release.DownloadUrl; Version = $release.Version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion