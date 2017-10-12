$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.16.0-x64.msi'
    checksum = '4228DF900E85D837F757AEE46D69D65E733C37872E948FF8D8EB5BFF324E56AA'
}

Install-Package $arguments
