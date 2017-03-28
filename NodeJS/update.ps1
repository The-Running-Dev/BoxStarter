Import-Module AU

$releasesUrl = 'https://nodejs.org/en/download/current/'
$versionRegEx = 'node-v(.+)-x64.msi'

function global:au_BeforeUpdate {
    Remove-Item "$PSScriptRoot\tools\*.msi"

    $client = New-Object System.Net.WebClient
    try
    {
        $filePath32 = "$PSScriptRoot\tools\$($Latest.FileName32)"
        $client.DownloadFile($Latest.Url32, $filePath32)
    }
    finally
    {
        $client.Dispose()
    }

    $Latest.Checksum32 = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath32 | ForEach-Object Hash
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
  $downloadPage = Invoke-WebRequest -Uri $releasesUrl -UseBasicParsing
  $url = $downloadPage.links | Where-Object href -match $versionRegEx | Select-Object -First 1 -expand href
  $version = $matches[1]
  
  $Latest.ChecksumType = 'sha256'  
  $Latest.FileName32 = [IO.Path]::GetFileName($url)

  return @{ Url32 = $url; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion -force