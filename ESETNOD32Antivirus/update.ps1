Import-Module au

$global:getBetaVersion = $false
$global:stableVersionDownloadUri = 'https://www.dropbox.com/download?full=1&plat=win'
$global:stableVersionRegEx = '.*Dropbox%20([0-9\.]+).*'
$global:betaVersionReleasePageUri = 'https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016'
$global:betaVersionDownloadUri = 'https://clientupdates.dropboxstatic.com/client/Dropbox%20$($betaVersion)%20Offline%20Installer.exe'
$global:betaVersionRegEx = '.*Beta-Build-([0-9\.\-]+).*'

function global:Get-FirstBetaLink([string] $uri, [string] $regEx) {
  $html = Invoke-WebRequest -UseBasicParsing -Uri $uri

  return $html.links | Where-Object { $_.href -match $regEx } | Select-Object -First 1
}

function au_BeforeUpdate() {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
}

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
  if ($global:getBetaVersion) {
    $betaVersion = ((Get-FirstBetaLink $global:betaVersionReleasePageUri $global:betaVersionRegEx) -replace $global:betaVersionRegEx, '$1') -replace '-', '.'
    $betaVersionDownloadUri = $ExecutionContext.InvokeCommand.ExpandString($global:betaVersionDownloadUri)

    return @{ Url32 = $betaVersionDownloadUri; Version = $betaVersion }
  }

  $stableVersionDownloadUri = ((Get-WebURL -Url $global:stableVersionDownloadUri).ResponseUri).AbsoluteUri
  $stableVersion = $($stableVersionDownloadUri -replace $global:stableVersionRegEx, '$1')

  return @{ Url32 = $stableVersionDownloadUri; Version = $stableVersion }
}

update -ChecksumFor none