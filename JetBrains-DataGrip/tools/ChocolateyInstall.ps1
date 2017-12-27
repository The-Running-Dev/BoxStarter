$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.3.3.exe'
    checksum        = '713DBAD4D526802B11E9BF34AB87219653697606D63C8447033911DB50F2B543'
    silentArgs      = '/S'
}

Install-Package $arguments
