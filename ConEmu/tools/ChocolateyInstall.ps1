$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.08.19/ConEmuSetup.170819.exe'
    checksum        = 'E831E0CD8E371A063314B9CA58B4C9DCEF32247EEDC73DDAB5ABAD10467361A8'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
