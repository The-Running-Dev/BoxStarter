Import-Module AU

$releasesUrl = 'http://www.filehorse.com/download-vmware-workstation/'
$downloadUrl = 'https://download3.vmware.com/software/wkst/file/VMware-workstation-full-$($fileVersion).exe'
$versionRegEx = '.*VMware Workstation ([0-9\.]+) Build ([0-9]+)'

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

  $versionInfo = [regex]::match($html.Content, $versionRegEx)
  $version = $versionInfo.Groups[1].Value
  $build = $versionInfo.Groups[2].Value
  
  $fileVersion = "$version-$build"
  $versionDownloadUrl = $ExecutionContext.InvokeCommand.ExpandString($downloadUrl)
  
  return @{ Url32 = $versionDownloadUrl; Version = $version }
}

Update-Package -ChecksumFor none -NoCheckChocoVersion