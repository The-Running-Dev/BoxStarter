$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.2018.3.13-x64.msi'
    checksum    = 'BDFF2F7D93AA90D20C807070382D6C7346D284F330851E346609A367A72DBED6'
}

Install-Package $arguments
