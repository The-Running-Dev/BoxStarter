$arguments          = @{
    url             = 'https://download.jetbrains.com/datagrip/datagrip-2017.2.2.exe'
    checksum        = 'B35B43280CDD8DE54781DA112AA728918260D02CEC8E21A0FE52670F823622DB'
    silentArgs      = '/S'
}

Install-Package $arguments
