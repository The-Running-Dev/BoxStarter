$arguments          = @{
    url             = 'https://github.com/git-lfs/git-lfs/releases/download/v2.4.0/git-lfs-windows-2.4.0.exe'
    checksum        = '345034FC91459579370737201E991C7A2E8ACABBB24D15577ECF588D071B1949'
    silentArgs      = '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES'
}

Install-Package $arguments
