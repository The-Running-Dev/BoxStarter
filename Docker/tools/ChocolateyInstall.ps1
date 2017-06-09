$arguments          = @{
    url             = 'https://download.docker.com/win/edge/InstallDocker.msi'
    checksum        = 'E348243EBD5A0C441F5018660DF4A8BB21C02AFA6A9D65B507864869AED2C1C4'
}

Install-Package $arguments
