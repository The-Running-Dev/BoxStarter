$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.07.30/ConEmuSetup.170730.exe'
    checksum        = '717C74CBC9D3F4845D80E0051CDBEF2CEA5160AE2DB911F823257A2C9CDF2CBF'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
