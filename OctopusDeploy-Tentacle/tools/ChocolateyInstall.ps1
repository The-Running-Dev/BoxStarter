$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.20.0-x64.msi'
    checksum = '7C6FD97732085B1A72344A9EA272A5BC3C8122139C3AA08E3317EB0B025D5FBB'
}

Install-Package $arguments
