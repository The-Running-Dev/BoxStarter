Import-Module AU

$releasesUrl = 'https://vscode-update.azurewebsites.net/api/update/win32/stable/VERSION'

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
    $json = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl | ConvertFrom-Json

    return @{ Url32 = $json.Url; Version = $json.productVersion }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion