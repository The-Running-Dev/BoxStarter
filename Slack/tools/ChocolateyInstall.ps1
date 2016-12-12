$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'Slack'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'SlackSetup.exe'
  url             = 'https://slack.com/ssb/download-win'
  url64           = 'https://slack.com/ssb/download-win64'
  softwareName    = 'Slack*'
  checksum        = '778AF18E6E114EBF7C70BC355496CF30900D91A86E43C14D1A4EA91EC408802A'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs