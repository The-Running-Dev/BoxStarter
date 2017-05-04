$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.1.2.exe'
    checksum        = '30743F86A7CD9043CFE158F6BE28387E1FD9263DA2D018659879B379140ECDE0'
    silentArgs      = '/S'
}

Install-Package $arguments
