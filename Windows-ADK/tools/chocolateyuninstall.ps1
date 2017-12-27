
<#
.SYNOPSIS
Uninstall windows-adk-all

.DESCRIPTION
Uninstalls the Windows Assessment and Deployment Kit using the Chocolatey framework

.LINK
https://msdn.microsoft.com/en-us/windows/hardware/dn913721.aspx
#>

$Key = @( 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
          'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
          'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' ) |
   Get-ItemProperty -ErrorAction SilentlyContinue | 
   where-object DisplayName -match 'Windows Assessment and Deployment Kit'

$Key | Out-String | Write-Verbose

$ChocoPackage = @{
    SilentArgs = '/uninstall /quiet'
    packageName = 'Windows Assessment and Deployment Kit'
    fileType = 'exe'
    file = $key.BundleCachePath
    validExitCodes = @(0,3010)
}

Uninstall-ChocolateyPackage @ChocoPackage

