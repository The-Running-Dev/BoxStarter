$configFile = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) '..\Configuration.xml'

$packageName = 'Office365Business'
$installerType = 'EXE'
$url = 'https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_7614-3602.exe'
$checksum = 'CB9B41ABF4C3D67D082BA534F757A0C84F7CA4AF89D77590CC58290B7C875F5E'
 
$silentArgs = "/extract:$env:temp\office /log:$env:temp\officeInstall.log /quiet /norestart"
$validExitCodes = @(0)

$architecture = (Get-WmiObject win32_processor | Where-Object{$_.deviceID -eq "CPU0"}).AddressWidth

If ($architecture -eq 64) {
   $configFile = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) '..\configuration64.xml'
}

Write-Host "Extracting to $silentArgs"
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes -Checksum $checksum -ChecksumType "sha256"
Install-ChocolateyInstallPackage "$packageName" "$installerType" "/download $configFile" "$env:temp\office\setup.exe"
Install-ChocolateyInstallPackage "$packageName" "$installerType" "/configure $configFile" "$env:temp\office\setup.exe"