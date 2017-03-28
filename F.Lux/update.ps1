Import-Module AU

$releasesUrl = 'http://www.filehorse.com/download-flux/'
$downloadUrl = 'https://justgetflux.com/flux-setup.exe'
$versionRegEx = '.*f.lux ([0-9\.]+)'

function global:au_BeforeUpdate() {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
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
  $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl

  $version = [regex]::match($html.Content, $versionRegEx).Groups[1].Value
  
  return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion