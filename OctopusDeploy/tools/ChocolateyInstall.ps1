$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.2018.4.12-x64.msi'
    checksum    = 'EFDF3888160237FFCC1FC5DA30C6F1794CDEF50CA4B1F58B30A23031F610E0A8'
}

Install-Package $arguments
