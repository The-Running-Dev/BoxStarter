$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.12.17/ConEmuSetup.171217.exe'
    checksum        = 'BE7E833E051855CA30132179DD3CCDF33A957F3E9BBB8C5C1479CE95743A9935'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
