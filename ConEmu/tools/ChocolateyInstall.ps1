$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v18.05.06/ConEmuSetup.180506.exe'
    checksum        = '4557380F8FB42CADFA40FBA46E731C234A53DDEF436DC1C0172B9F5B3AD47073'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
