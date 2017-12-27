$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.4.1.5-x64.msi'
    checksum    = '3337FE47E93CA300B2124AC48B230572ACCE9C52D0E9BCDF1D827EB7BFA74744'
}

Install-Package $arguments
