$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.5.1/npp.7.5.1.Installer.x64.exe'
    checksum               = 'C915B780683EF5F2356671233F24CD7A9A4713A7288EA36B6333C1474CDD178D'
    silentArgs             = '/S'
}

Install-Package $arguments
