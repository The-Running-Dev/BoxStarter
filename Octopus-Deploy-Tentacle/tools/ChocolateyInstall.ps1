$arguments = @{
    url      = 'https://download.octopusdeploy.com/octopus/Octopus.Tentacle.3.15.6-x64.msi'
    checksum = '2DD4C8F72AAF2C47982DBEB0DC3E93D7BD4376062A8802DBB406A92EB306FA7C'
}

Install-Package $arguments
