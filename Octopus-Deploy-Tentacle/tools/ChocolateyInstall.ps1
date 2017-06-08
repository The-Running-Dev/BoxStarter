$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.13.10-x64.msi'
    checksum = 'A715FE0A487F18B4104898AA4AB77DB0E11014328E53021DE2BB4FA175F90DE3'
}

Install-Package $arguments
