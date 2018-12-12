$arguments          = @{
    url             = 'https://github.com/git-lfs/git-lfs/releases/download/v2.6.1/git-lfs-windows-v2.6.1.exe'
    checksum        = '6A5C78FE5FBBA3A23D739B4C3C19C9047B0DFB8EB008013745F6CBF6875F3C55'
    silentArgs      = '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES'
}

Install-Package $arguments
