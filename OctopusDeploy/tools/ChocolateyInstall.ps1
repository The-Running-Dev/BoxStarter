$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.2018.4.11-x64.msi'
    checksum    = 'B258679F1D9DCE36000B2C218A2444F39E801721F7CE120159D1BCABCACAA643'
}

Install-Package $arguments
