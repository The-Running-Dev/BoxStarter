$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.13.7-x64.msi'
    checksum    = 'E3D79F9AEF52939EDD707874963E2CE47C1762F1FBA5CB426180DA83329D82F0'
}

Install-Package $arguments
