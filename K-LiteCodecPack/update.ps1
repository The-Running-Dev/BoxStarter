Import-Module AU

$releasesUrl = 'http://codecguide.com/download_k-lite_codec_pack_mega.htm'
$downloadUrl = 'http://files2.codecguide.com/K-Lite_Codec_Pack_$($fileVersion)_Mega.exe'
$versionRegEx = '.*Version ([0-9\.]+) Mega'
$checksumRegEx = '.*<strong>SHA256<\/strong>: ([a-z0-9]+)'

$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$downloadFile = Join-Path $currentDir "tools\$([System.IO.Path]::GetFileNameWithoutExtension($Latest.URL32))_x32.exe"
$packagesDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter'
$installersDir = Join-Path -Resolve $currentDir '..\..\..\BoxStarter\Installers'
$file = Join-Path $installersDir $([System.IO.Path]::GetFileName($Latest.Url32))

function global:au_BeforeUpdate {
    Get-RemoteFiles

    Move-Item $downloadFile $file -Force

    $Latest.ChecksumType32 = 'sha256'
    $Latest.Checksum32 = (Get-FileHash $file -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash).ToLowerInvariant()
}

function global:au_AfterUpdate {
    Get-ChildItem $currentDir -Filter '*.nupkg' | ForEach-Object { Move-Item $_.FullName $packagesDir -Force }
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
  $html = Invoke-WebRequest -UseBasicParsing -Uri $releasesUrl

  $version = [regex]::match($html.Content, $versionRegEx).Groups[1].Value
  #$Latest.checksum = [regex]::match($html.Content, $checksumRegEx).Groups[1].Value

  $fileVersion = $version -replace '\.', ''
  $downloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)

  return @{ Url32 = $downloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion