$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.2.3.exe'
    checksum        = '136E336950491A172ECA08BA9853612F4E18285CAAA31E780EE56FE438B8F0D6'
    silentArgs      = '/S'
}

Install-Package $arguments
