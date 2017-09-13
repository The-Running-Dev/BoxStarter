$arguments          = @{
    url             = 'https://download.docker.com/win/stable/InstallDocker.msi'
    checksum        = '9C0DAB3A82E3CAFBEBBB48996F26E04C378FC420562DA6E6C77352786985D89B'
}

Install-Package $arguments
