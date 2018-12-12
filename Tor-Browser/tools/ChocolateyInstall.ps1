$arguments = @{
    url        = 'https://www.torproject.org/dist/torbrowser/8.0.4/torbrowser-install-8.0.4_en-US.exe'
    checksum   = 'FCF5578D459CE0F906EDCBEBBF08A5A9D9E53763945F39605106DAAEC40FDC02'
    silentArgs = '/S'
}

Install-Package $arguments
