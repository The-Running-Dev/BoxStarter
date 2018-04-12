$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2018.1.exe'
    checksum        = 'BA75B7C011BD193FA6E06AF8DA35FA4182A18568CDAA358353837E695A64950A'
    silentArgs      = '/S'
}

Install-Package $arguments
