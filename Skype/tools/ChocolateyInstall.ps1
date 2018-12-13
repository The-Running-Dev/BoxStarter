$arguments = @{
    url         = 'https://endpoint920510.azureedge.net/s4l/s4l/download/win/Skype-8.36.0.52.exe'
    checksum    = '7788D5BEAC2AB535B7D9E597C34719AB062D75C5515289B6EE58C663A1AD0422'
    silentArgs  = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
}

Install-Package $arguments

Stop-Process -ProcessName 'Skype'

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" Skype* | Remove-Item

# Remove from Windows startup
Remove-ItemProperty `
    -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' `
    -Name 'Skype for Desktop' -ErrorAction SilentlyContinue
