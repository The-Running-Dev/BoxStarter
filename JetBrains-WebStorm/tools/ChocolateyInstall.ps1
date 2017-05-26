$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.1.3.exe'
    checksum        = '35A09F65713C7B31F40EFC355BEF6370EE2541D561FB180F8A084411364CEBA3'
    silentArgs      = '/S'
}

Install-Package $arguments
