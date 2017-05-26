$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.13.7-x64.msi'
    checksum = '945B7F430D26173FD39F50DE2ED87679ECF5FB27135D8EBA6354F6AFC259CA9F'
}

Install-Package $arguments
