$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2018.1.2.exe'
    checksum        = 'FB120CAFB9F24736FF1860102B4787DB2C8372779A1AEA9B592140E4A5B6C7CA'
    silentArgs      = '/S'
}

Install-Package $arguments
