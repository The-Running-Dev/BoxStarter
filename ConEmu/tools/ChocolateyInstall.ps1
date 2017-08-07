$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.08.05/ConEmuSetup.170805.exe'
    checksum        = '0FBA243FB182A4056B270AA925E790A021FC625C13CEA6EDBAA2D5ACB82E5A39'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
