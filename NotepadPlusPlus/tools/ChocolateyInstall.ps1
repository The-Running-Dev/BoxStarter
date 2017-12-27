$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.5.3/npp.7.5.3.Installer.x64.exe'
    checksum               = 'FFCDE52E57CAFFAF909DC52C1AE3C107443F99794374B927929830B92608736E'
    silentArgs             = '/S'
}

Install-Package $arguments
