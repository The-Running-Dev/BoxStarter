$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.6.1/npp.7.6.1.Installer.x64.exe'
    checksum               = 'C40C49D698AC179EA01C38FD6DA20EBE87D97D4F299BBBBF121BCD60C68B9CA7'
    silentArgs             = '/S'
}

Install-Package $arguments
