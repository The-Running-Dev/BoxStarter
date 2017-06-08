$arguments          = @{
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = '2A1578FA1D519103DD8A8E0032A45633DE0458745CD6CE850E4A345711E6A85F'
    silentArgs      = '/s'
}

Install-Package $arguments
