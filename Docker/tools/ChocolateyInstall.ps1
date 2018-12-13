$arguments = @{
    url            = 'https://download.docker.com/win/stable/Docker for Windows Installer.exe'
    checksum       = 'E5A94CDE5D94DD15AC83D6ACCAE92EAA5BE64BC93BFEDC05A84C19EC9F5ADCB6'
    silentArgs     = "install --quiet"
    validExitCodes = @(0, 3010, 1641)
}

Install-Package $arguments

Start-Sleep 10

# Remove the shortcut on the desktop
Get-ChildItem "$env:UserProfile\Desktop" Docker* | Remove-Item

# Remove from Windows startup
Remove-ItemProperty `
    -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' `
    -Name 'Docker for Windows' -ErrorAction SilentlyContinue
