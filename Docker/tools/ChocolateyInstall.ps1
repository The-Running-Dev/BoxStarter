$arguments          = @{
    url             = 'https://download.docker.com/win/stable/InstallDocker.msi'
    checksum        = '3F864728959FE810F4FD132EB0411F3C5BB998C7CCCDEBEA90347BD936C57FD7'
}

Install-Package $arguments
