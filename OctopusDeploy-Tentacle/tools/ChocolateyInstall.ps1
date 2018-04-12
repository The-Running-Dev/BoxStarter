$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.19.1-x64.msi'
    checksum = '350A61AE0238766BCED491AEC9EF7909E0FF2319EBC6485D01E7B1AE60545EE9'
}

Install-Package $arguments
