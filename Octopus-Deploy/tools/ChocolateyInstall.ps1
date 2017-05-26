$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.13.3-x64.msi'
    checksum    = 'FFFCC816BB8FB48AC1C80D1DF44F4BA1FAB19C522F1A8C643A13083B142A44F0'
}

Install-Package $arguments
