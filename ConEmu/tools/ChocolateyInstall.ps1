$arguments          = @{
    file            = 'ConEmuSetup.170402.exe'
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.04.02/ConEmuSetup.170402.exe'
    checksum        = 'E45D38BA862B0798A59E19A050CD0A9DCC7567DE7CC2E79627303AC597CA6CDE'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
