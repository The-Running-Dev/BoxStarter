$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.2.4.exe'
    checksum        = 'E0DF590F3FA7C796B8C1E106429ED01C74E8F231DB3F5E1700E1907EEB8FED02'
    silentArgs      = '/S'
}

Install-Package $arguments
