$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.17.5-x64.msi'
    checksum    = '2FD7FC38B1CEB55E2FDB0BB786E5F2EB8B1379E0F6062CEDB6BF374C82946DFB'
}

Install-Package $arguments
