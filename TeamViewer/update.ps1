Import-Module AU

$currentDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$downloadUrl = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
$fileType = 'exe'
$checksumType = 'sha256'
$file = Join-Path $currentDir "tools\$([System.IO.Path]::GetFileNameWithoutExtension($Latest.URL32))_x32.exe"

function Get-CustomVersion([string] $file) {
    return [System.Diagnostics.FileVersionInfo]::GetVersionInfo($file) | % {
      [Version](($_.FileMajorPart, $_.FileMinorPart, $_.FileBuildPart) -join ".") 
    }
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
  $Latest.Url32 = $downloadUrl
  $Latest.FileType = $fileType
  $Latest.ChecksumType32 = $checksumType

  Get-RemoteFiles

  if (Test-Path $:file) {
    $stableVersion = Get-CustomVersion $file
    $Latest.Checksum32 = (Get-FileHash $file -Algorithm $checksumType | ForEach Hash).ToLowerInvariant()

    Remove-Item $file -Force
  }

  return @{ Url32 = $Latest.Url32; Version = $stableVersion }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion