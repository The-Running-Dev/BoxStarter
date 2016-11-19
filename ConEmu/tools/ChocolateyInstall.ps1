$packagePath = join-path (Split-Path -parent $MyInvocation.MyCommand.Definition) .. -Resolve

$package = 'ConEmu'
$version = '16.10.22'
$sha256 = '1E43A75E1E300855A02B60A47102DD7222EA36897AA01FCA315CB1BC6682C711'
$installDirectory = 'C:\Program Files\ConEmu'
$wallpapersDirectory = 'wallpapers'
$settingsFile = 'ConEmu.xml'

$isSytem32Bit = (($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
  ($Env:PROCESSOR_ARCHITEW6432 -eq $null))
 
$os = if ($isSytem32Bit) { "x86" } else { "x64" }
 
$url = "https://github.com/Maximus5/ConEmu/releases/download/v$version/ConEmuSetup.$($version.replace('.','')).exe"
 
# MSI installer, but packed inside wrapper to select x86 or x64
# version. Therefore, treat it as EXE type.
$params = @{
  PackageName = $package;
  FileType = 'exe';
  SilentArgs = "/p:$os /quiet /norestart";
  Url = $url;
  Url64bit = $url;
  checksum      = $sha256
  checksumType  = 'sha256'
  checksum64    = $sha256
  checksumType64= 'sha256'
}
Install-ChocolateyPackage @params

Copy-Item -Recurse -Force $packagePath\$wallpapersDirectory $installDirectory
Copy-Item -Force $packagePath\$settingsFile $installDirectory\$settingsFile
Copy-Item -Force $packagePath\$settingsFile $env:APPDATA\$settingsFile