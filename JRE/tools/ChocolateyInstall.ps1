function thisJreInstalled($version) {
  $productSearch = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match '^Java \d+ Update \d+'}

  # The regexes for the name of the JRE registry entries (32- and 64 bit versions)
  $nameRegex32 = '^Java \d+ Update \d+$'
  $nameRegex64 = '^Java \d+ Update \d+ \(64-bit\)$'
  $versionRegex = $('^' + $version + '\d*$')

  $x86_32 = $productSearch | Where-Object {$_.Name -match $nameRegex32 -and $_.Version -match $versionRegex}
  $x86_64 = $productSearch | Where-Object {$_.Name -match $nameRegex64 -and $_.Version -match $versionRegex}
  
  if($x86_32 -eq $null)
  {
    $x86_32 = $false
  }
  
  if($x86_64 -eq $null)
  {
    $x86_64 = $false
  }
   
  return $x86_32,$x86_64
}

$script           = $MyInvocation.MyCommand.Definition
$x86Installer     = Join-Path (Get-ParentDirectory $script) 'jre-8u111-windows-i586.exe'
$x64Installer     = Join-Path (Get-ParentDirectory $script) 'jre-8u111-windows-x64.exe'
$packageArgs      = @{
  packageName     = 'JRE'
  softwareName    = 'JRE*'
  version         = '8.0.1110.14'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = $x64Installer
  url             = 'https://javadl.oracle.com/webapps/download/AutoDL?BundleId=216432'
  url64           = 'https://javadl.oracle.com/webapps/download/AutoDL?BundleId=216434'
  checksum        = '03A2463DDE28E2DB03C64723D75A1A3B55A3454449FC2411A749E16B1D9F80AE'
  checksum64      = '932DEC1BF86B6361EBCC4DFE3B097C9A76D7EA2C109FC9A3241C69FABB5C12CB'
  checksumType    = 'sha256'
  checksumType64  = 'sha256'
  silentArgs      = "/s REBOOT=0 SPONSORS=0 AUTO_UPDATE=0 REMOVEOUTOFDATEJRES=1"
  validExitCodes  = @(0, 3010, 1641)
}

$parameters = ParseParameters $env:chocolateyPackageParameters
if($parameters.ContainsKey("exclude")) {
    $exclude = $arguments["exclude"]
}

$thisJreInstalledHash = thisJreInstalled($version)

if (!($thisJreInstalledHash[0]) -and !($thisJreInstalledHash[1])) {
  Install-LocalOrRemote $packageArgs
}
else {
  if ((Get-ProcessorBits) -eq 64) {
    if (!($thisJreInstalledHash[1]) -and $exclude -ne '64') {
      Install-LocalOrRemote $packageArgs
    } 
  }

  if (!($thisJreInstalledHash[0]) -and $exclude -ne '32') {
    $packageArgs['file'] = $x86Installer
    $packageArgs['url64'] = ''
    $packageArgs['checksum64'] = ''
    Install-LocalOrRemote $packageArgs
  }
}

#Uninstalls the previous version of Java if either version exists
$oldJreInstalledHash = thisJreInstalled($oldVersion)

if ($oldJreInstalledHash[0]) 
{
    $32 = $oldJreInstalledHash[0].IdentifyingNumber
    Start-ChocolateyProcessAsAdmin "/qn /norestart /X$32" -exeToRun "msiexec.exe" -validExitCodes @(0,1605,3010)
}

if ($oldJreInstalledHash[1])
{
    $64 = $oldJreInstalledHash[1].IdentifyingNumber
    Start-ChocolateyProcessAsAdmin "/qn /norestart /X$64" -exeToRun "msiexec.exe" -validExitCodes @(0,1605,3010)
}