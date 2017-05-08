$arguments          = @{
    url             = 'https://download.docker.com/win/edge/InstallDocker.msi'
    checksum        = 'B468E4127EBAE5318312C4A3F5FC0E1B0A6A8E74386CF499E4DB459EB442E81E'
}

Install-Package $arguments
