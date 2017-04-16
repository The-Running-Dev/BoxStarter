$arguments          = @{
    file            = 'SlackSetup.exe'
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = 'EA1D6A7F8EA1B6B18FDFA6387A21AE3F56666C8423AB5E7744C3D4B4337BAF18'
    silentArgs      = '/s'
}

Install-CustomPackage $arguments
