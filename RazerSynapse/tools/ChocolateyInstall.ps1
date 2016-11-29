$packagePath = Join-Path -Resolve $(Split-Path -parent $MyInvocation.MyCommand.Definition) ..

$packageName = 'RazerSynapse'
$installer = 'Razer_Synapse_Framework.exe';
$url = 'http://www.razerzone.com/synapse/downloadpc'

$tempDir = Join-Path $(Get-Item $env:TEMP) $packageName
$installerPath = "$tempDir\$installer"

New-Item -ItemType Directory $tempDir
Invoke-WebRequest -Uri $url -OutFile $installerPath

Start-Process $packagePath\Install.exe
Start-Process $installerPath -Wait