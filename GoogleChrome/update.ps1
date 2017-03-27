import-module au
. "$PSScriptRoot\..\..\scripts\Get-Padded-Version.ps1"

$releases = 'http://omahaproxy.appspot.com/all?os=win&amp;channel=stable'
$paddedUnderVersion = '56.0.2925'

function global:au_SearchReplace {
  return @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
    $release_info = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = $release_info | % Content | ConvertFrom-Csv | % current_version

    @{
        URL32 = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi'
        URL64 = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
        Version = Get-Padded-Version -Version $version -OnlyBelowVersion $paddedUnderVersion -RevisionLength 5
    }
}

update