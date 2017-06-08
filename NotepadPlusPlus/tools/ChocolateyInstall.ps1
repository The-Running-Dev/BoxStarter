$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.3.3/npp.7.3.3.Installer.x64.exe'
    checksum               = '656E7A31EE07D7FEBCB49822DD166CB72AFE23D4DCCF546F2C6B45BCD959E5A1'
    silentArgs             = '/S'
}

Install-Package $arguments
