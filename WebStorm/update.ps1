Import-Module AU

$global:productName = 'WebStorm'
$global:updatesUri = 'https://www.jetbrains.com/updates/updates.xml'
$global:stableVersionDownloadUri = 'https://download.jetbrains.com/webstorm/webstorm-${stableVersion}.exe'

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
  [xml] $updates = (New-Object System.Net.WebClient).DownloadString($global:updatesUri)
  $latestVersion = $updates.products.product `
    | Where-Object { $_.name -eq $global:productName } `
    | ForEach { $_.channel } `
    | ForEach { $_.build } `
    | Sort-Object { $_.releaseDate, $_.number } `
    | Select-Object -Last 1

  $stableVersion = $latestVersion.Version
  write-host $stableVersion
  
  $stableVersionDownloadUri = $ExecutionContext.InvokeCommand.ExpandString($global:stableVersionDownloadUri)

  return @{ Url32 = $stableVersionDownloadUri; Version = $stableVersion }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion