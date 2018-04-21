$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2018.1.1.exe'
    checksum        = '1E0207A23197FA6FD87BF04A58C55CB8548C54445B94B49E3699E12F0F106983'
    silentArgs      = '/S'
}

Install-Package $arguments
