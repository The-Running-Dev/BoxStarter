$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.15.5-x64.msi'
    checksum = 'DE505A54108AC6D8CF9C97A5BD307C61CDA9532CA84615CA0418E76B528E2A7D'
}

Install-Package $arguments
