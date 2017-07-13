$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.1.5.exe'
    checksum        = '7AB30463BE1BABB5D0ABE961EFBAB50421C3C340A35B5EEBDF80CC91F7EF68E5'
    silentArgs      = '/S'
}

Install-Package $arguments
