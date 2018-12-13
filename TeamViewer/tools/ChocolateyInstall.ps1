$arguments          = @{
    url             = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum        = 'CE34113260805F46169CC8569440F62EE5EDF3E7C252BF0CB8393B285BA57C1F'
    silentArgs      = '/S'
}

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" TeamViewer* | Remove-Item
