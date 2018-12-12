$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.6/npp.7.6.Installer.x64.exe'
    checksum               = '8EC624C110AE1A3FC9A06A0BA8D8AC2BFCE42898ED10458C50C5F8707E181FAE'
    silentArgs             = '/S'
}

Install-Package $arguments
