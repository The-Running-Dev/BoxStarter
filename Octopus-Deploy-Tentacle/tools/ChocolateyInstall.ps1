$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.15.8-x64.msi'
    checksum = 'FD80126D04A6E261CBFFF11949E4D0BF828B6B85BCBE35177B0E819BB0E70CC4'
}

Install-Package $arguments
