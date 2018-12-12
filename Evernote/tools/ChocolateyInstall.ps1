$arguments      = @{
    url         = 'https://cdn1.evernote.com/win6/public/Evernote_6.16.4.8094.exe'
    checksum    = '14EBEBB107AEDF61FE7BEDCAA40CFAE8D851685EDC9D258A6D7256824F49B467'
    silentArgs  = '/quiet'
}

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" Evernote* | Remove-Item
