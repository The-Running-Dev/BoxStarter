$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.05.17/ConEmuSetup.170517.exe'
    checksum        = 'EA4D33EA29085795DDD1CD1A9D6B66914717F90AB812CF9CCA4C4E65E888262A'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
