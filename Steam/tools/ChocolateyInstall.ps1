$arguments = @{
    url            = 'https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe'
    checksum       = '029F918A29B2B311711788E8A477C8DE529C11D7DBA3CAF99CBBDE5A983EFDAD'
    silentArgs     = '/S'
    validExitCodes = @(0, 2)
}

Install-Package $arguments
