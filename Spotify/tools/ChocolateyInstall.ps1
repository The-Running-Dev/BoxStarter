Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Helpers.psm1')

$installer = 'SpotifyFullSetup.exe'
$url = "https://download.spotify.com/$installer"

$tempDir = Join-Path $(Get-Item $env:TEMP) $packageName
$installerPath = "$tempDir\$installer"

New-Item -ItemType Directory $tempDir
Invoke-WebRequest -Uri $url -OutFile $installerPath

$taskname = 'Install Spotify'
$action = New-ScheduledTaskAction -Execute $installerPath -Argument /silent
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date)
Register-ScheduledTask -TaskName $taskname -Action $action -Trigger $trigger
Start-ScheduledTask -TaskName $taskname
Start-Sleep -s 1
Unregister-ScheduledTask -TaskName $taskname -Confirm:$false