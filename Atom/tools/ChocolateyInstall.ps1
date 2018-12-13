$arguments = @{
    url        = 'https://github.com/atom/atom/releases/download/v1.33.0/AtomSetup-x64.exe'
    checksum   = 'E61D4040C48DEB64F3B8FF3D7B677515B1142CE16055DFB878AEF3EB0579B981'
    silentArgs = '--silent'
}

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:UserProfile\Desktop" Atom* | Remove-Item
