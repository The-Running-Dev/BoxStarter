$script           = $MyInvocation.MyCommand.Definition
$packageName      = 'Slack'
$installer        = Join-Path (GetParentDirectory $script) 'SlackSetup.exe'
$url              = 'https://slack.com/ssb/download-win'
$url64            = 'https://slack.com/ssb/download-win64'
$packageArgs      = @{
  packageName     = $packageName
  unzipLocation   = (GetCurrentDirectory $script)
  fileType        = 'exe'
  file            = $installer
  url             = $url
  url64           = $url
  softwareName    = 'Slack*'
  checksum        = '778AF18E6E114EBF7C70BC355496CF30900D91A86E43C14D1A4EA91EC408802A'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

InstallFromLocalOrRemote $packageArgs