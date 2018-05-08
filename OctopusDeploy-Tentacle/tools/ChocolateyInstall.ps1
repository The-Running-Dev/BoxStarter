$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.20.1-x64.msi'
    checksum = 'D31C90C276A246EEA371AE232F5E2D4AACECE1568D057452CD6C899969C5C86A'
}

Install-Package $arguments
