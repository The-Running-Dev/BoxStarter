Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Helpers.psm1')

$packageName = "slack"
$url = "https://slack.com/ssb/download-win"

Install $packageName $url