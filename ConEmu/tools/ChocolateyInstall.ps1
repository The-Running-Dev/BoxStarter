$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.06.05/ConEmuSetup.170605.exe'
    checksum        = '96B5BCCFCDD3BEFC56CEC380D6E64D2C582CB9C8AE5AE2CB79569BE73D92C817'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
