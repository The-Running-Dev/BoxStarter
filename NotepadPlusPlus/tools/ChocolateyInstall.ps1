$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.4.2/npp.7.4.2.Installer.x64.exe'
    checksum               = 'BB89C0811F8566C21EDA6E5880ADDED61204EBA0F13DE9631F91E7E4C768CCCD'
    silentArgs             = '/S'
}

Install-Package $arguments
