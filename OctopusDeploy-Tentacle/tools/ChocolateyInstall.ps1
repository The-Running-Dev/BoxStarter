$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.16.2-x64.msi'
    checksum = 'D90618CD4EFC743455527C2CA0853DCA3F3AC0979E7E93FE047E49AAC7FB121F'
}

Install-Package $arguments
