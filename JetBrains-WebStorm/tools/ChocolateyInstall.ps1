$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2018.1.3.exe'
    checksum        = '3AF0A9EB90A1F2C1767224280C4F3767EAEF526DA559A94B7C18306008CA3B48'
    silentArgs      = '/S'
}

Install-Package $arguments
