$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.14.1-x64.msi'
    checksum = 'EA6460FB148DCC2BD8C056CBAE3D95D78EB00C9D5BEBCD95C0F934BC95AEF97A'
}

Install-Package $arguments
