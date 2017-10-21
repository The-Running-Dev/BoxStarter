$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.17.8-x64.msi'
    checksum    = '9CA809DD89CF9DCB62D9CFF728AA1155A004D1DEB6530F1B340339FAF27D2532'
}

Install-Package $arguments
