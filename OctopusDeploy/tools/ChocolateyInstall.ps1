$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.2018.9.16-x64.msi'
    checksum    = 'B3967C78BDC050F83072C42728D75B51774AD95C853712293EF65880DCBB04CB'
}

Install-Package $arguments
