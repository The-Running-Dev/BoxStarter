$arguments = @{
    url            = 'https://download.docker.com/win/stable/Docker for Windows Installer.exe'
    checksum       = '4F48AB087DB0162BB5BC6DF08222A1B61AEFCFE06296CFEE1CFC02D483AD11BD'
    silentArgs     = "install --quiet"
    validExitCodes = @(0, 3010, 1641)
}

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:UserProfile\Desktop" Docker* | Remove-Item

# Remove from Windows startup
Remove-ItemProperty `
    -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' `
    -Name 'Docker for Windows'
