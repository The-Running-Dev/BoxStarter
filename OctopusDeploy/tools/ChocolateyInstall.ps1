$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.2018.4.10-x64.msi'
    checksum    = '0580EDFE39394BF1D58AC59CEA1FD438AC257BD88839221F27932A284D94C7A0'
}

Install-Package $arguments
