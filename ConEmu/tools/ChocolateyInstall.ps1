$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.12.03/ConEmuSetup.171203.exe'
    checksum        = 'FAC5BAF03A6BC463303AB68B6CFD2CE7E6F21E1D91BC52C1BCABBE61EE1FBD7D'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
