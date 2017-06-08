$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.13.10-x64.msi'
    checksum    = '9991B2987688EB78C1BDEC89C63B60EA2A3796B7501F9292F74A7542AF408C49'
}

Install-Package $arguments
