$arguments          = @{
    url             = 'https://download.docker.com/win/stable/InstallDocker.msi'
    checksum        = 'B182A2802321EDDCEAF4C03C1F9DAF1CA17F9C93E0DEF925D80448ADB1F6AD20'
}

Install-Package $arguments
