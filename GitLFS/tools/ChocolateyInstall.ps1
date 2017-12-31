$arguments          = @{
    url             = 'https://github.com/git-lfs/git-lfs/releases/download/v2.3.4/git-lfs-windows-2.3.4.exe'
    checksum        = 'F11EE43EAE6AE33C258418E6E4EE221EB87D2E98955C498F572EFA7B607F9F9B'
    silentArgs      = '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES'
}

Install-Package $arguments
