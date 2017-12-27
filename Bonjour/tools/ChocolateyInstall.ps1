$arguments = @{
    url            = 'http://support.apple.com/downloads/DL999/en_US/BonjourPSSetup.exe'
    checksum       = '7F1EC347CD429CFB25A34B2147E02231334F28290E0C28BE213415B0F99DA1A0'
    executable     = "$env:Temp\Bonjour64.msi"
    silentArgs     = "/qn /norestart /l*v `"$($env:Temp)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log` ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0"
    validExitCodes = @(0, 3010, 1641)
}

Install-Package $arguments
