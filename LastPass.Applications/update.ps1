Import-Module AU

$releasesUrl = 'https://lastpass.com/misc_download2.php'
$downloadUrl = 'https://lastpass.com/download/cdn/lastappinstall_x64.exe'
$versionRegEx = 'lastappinstall\.exe.*?Version ([0-9\.]+)'

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
  $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl -UserAgent $userAgent

  $version = [regex]::match($html, $versionRegEx).Groups[1].Value
  $versiondownloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

  return @{ Url32 = $versiondownloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion