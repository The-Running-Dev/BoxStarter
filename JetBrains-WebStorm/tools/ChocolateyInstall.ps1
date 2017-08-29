$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.2.2.exe'
    checksum        = 'E64A500083D4F410FDAFB5BB4A04B6ACABFAD6C4CB1B1F3CB9E0651556B41E9D'
    silentArgs      = '/S'
}

Install-Package $arguments
