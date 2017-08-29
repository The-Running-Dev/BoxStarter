$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.16.5-x64.msi'
    checksum    = 'E325084E0BE8CBB804060DD7F5D433B28B9114BFA99528FF9A2FED999C27A884'
}

Install-Package $arguments
