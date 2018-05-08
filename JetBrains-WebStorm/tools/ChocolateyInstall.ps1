$arguments          = @{
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2018.1.2.exe'
    checksum        = '4387792E0ED4D3D3263D5386B8E3F78C53FC27DAE36434ACF27F747C68D498F3'
    silentArgs      = '/S'
}

Install-Package $arguments
