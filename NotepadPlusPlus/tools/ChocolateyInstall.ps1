$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.5.2/npp.7.5.2.Installer.x64.exe'
    checksum               = '8A29D259093776EAE774309CA3ED189FC3E780A8B0A86F1B557CEDDAF79D054E'
    silentArgs             = '/S'
}

Install-Package $arguments
