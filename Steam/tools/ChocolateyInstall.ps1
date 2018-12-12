$arguments = @{
    url            = 'https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe'
    checksum       = '3BC6942FE09F10ED3447BCCDCF4A70ED369366FEF6B2C7F43B541F1A3C5D1C51'
    silentArgs     = '/S'
    validExitCodes = @(0, 2)
}

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" Steam* | Remove-Item
