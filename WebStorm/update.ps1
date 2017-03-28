Import-Module AU

$productName = 'WebStorm'
$updatesUri = 'https://www.jetbrains.com/updates/updates.xml'
$stableVersionDownloadUrl = 'https://download.jetbrains.com/webstorm/WebStorm-$($version).exe'

function global:au_BeforeUpdate() {
  $checksumString = (New-Object System.Net.WebClient).DownloadString("$($Latest.Url32).sha256")
  $Latest.Checksum32 = $checksumString -replace '\s+.*', ''
  $Latest.ChecksumType32 = 'sha256'
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
  [xml] $updates = (New-Object System.Net.WebClient).DownloadString($updatesUri)
  $versionInfo = $updates.products.product `
    | ? { $_.name -eq $productName } `
    | % { $_.channel } `
    | % { $_.build } `
    | Sort-Object { [version] $_.number } `
    | Select-Object -Last 1

  $version = $versionInfo.Version

  if ($versionInfo.ReleaseDate) {
    $fullVersionNumber = "$($versionInfo.Version).$($versionInfo.ReleaseDate)"
  }
  else {
    $fullVersionNumber = "$($versionInfo.Version).0.0"
  }
  
  $stableVersionDownloadUrl = $ExecutionContext.InvokeCommand.ExpandString($stableVersionDownloadUrl)

  return @{ Url32 = $stableVersionDownloadUrl; Version = $fullVersionNumber }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion