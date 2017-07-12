$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.15.1-x64.msi'
    checksum = '70BF0CBC6597F6AE0941F2DA779EA1B03259FEF5AA6160B6FC7CEE8CE70C5180'
}

Install-Package $arguments
