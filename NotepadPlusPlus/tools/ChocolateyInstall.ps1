$arguments = @{
    url                    = 'https://notepad-plus-plus.org/repository/7.x/7.5.6/npp.7.5.6.Installer.x64.exe'
    checksum               = 'ADC915BAA76E80C26D04F0CE1DF6B592DA809B3E14815F5A53369A7F3A993A83'
    silentArgs             = '/S'
}

Install-Package $arguments
