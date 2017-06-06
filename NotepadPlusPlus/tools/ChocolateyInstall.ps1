$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.4.1/npp.7.4.1.Installer.x64.exe'
    checksum               = '7E63B7FB06EC318089193072485E96AC4EDEE5D277E1639D3F1A613885326CBC'
    silentArgs             = '/S'
}

Install-Package $arguments
