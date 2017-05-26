$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.1.4.exe'
    checksum        = '8EC99E69DBC5E2FCBF2C9D7E4C88E4BE390C08970799ECEAE4341C00062884FB'
    silentArgs      = '/S'
}

Install-Package $arguments
