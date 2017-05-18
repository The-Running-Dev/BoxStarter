$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.13.6-x64.msi'
    checksum = '16ACDF45D5683BCB3A2E2C7B81693DF6A08BFBB75028583F62A31A07B9A29D52'
}

Install-Package $arguments
