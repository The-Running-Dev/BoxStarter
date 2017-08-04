$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.16.0-x64.msi'
    checksum    = '1177AE72B5BB15C33971853A2A2F4308BD88A00DF667A620D40D7E3E217217BA'
}

Install-Package $arguments
