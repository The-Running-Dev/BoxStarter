$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.1.3.exe'
    checksum        = 'B1761F84D35EE751C8F7BDD9B2EB677D4439F52D3EF529EEED9F54BA3F0F2390'
    silentArgs      = '/S'
}

Install-Package $arguments
