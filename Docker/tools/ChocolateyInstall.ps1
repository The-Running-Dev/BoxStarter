$arguments = @{
    url            = 'https://download.docker.com/win/stable/Docker for Windows Installer.exe'
    checksum       = '87A5F9DCF593B55B22719E82931E85F41173504341CE98A06C8624E078977DB5'
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
