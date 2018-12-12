$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v18.06.26/ConEmuSetup.180626.exe'
    checksum        = 'AE2723E95AB1FA7A17BBB54E25EE813B5E6313AF6C0B68B36FCA46B1C0370A41'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" ConEmu* | Remove-Item
