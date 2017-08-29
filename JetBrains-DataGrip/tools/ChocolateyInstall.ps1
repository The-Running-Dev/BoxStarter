$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.2.1.exe'
    checksum        = '13F14B3907B10C1ADBD676E00EBE4ECAF97C25007B6604BB5FA2EF9156263831'
    silentArgs      = '/S'
}

Install-Package $arguments
