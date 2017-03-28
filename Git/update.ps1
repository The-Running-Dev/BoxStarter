$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Import-Module AU
Import-Module (Join-Path (Split-Path -Parent $currentDir) 'build-helpers.psm1') -Force

$gitHubRepository = 'git-for-windows/git'
$downloadUrlRegEx = '.*Git\-([0-9\.]+)\-64\-bit.exe'
$versionRegEx = '([0-9\.]+)\..*'

function global:au_BeforeUpdate() {
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

  return @{ Url32 = $release.DownloadUrl; Version = $release.Version -replace $versionRegEx, '$1' }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion