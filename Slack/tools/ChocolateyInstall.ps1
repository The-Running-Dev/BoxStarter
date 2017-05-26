$arguments          = @{
    url             = 'https://downloads.slack-edge.com/releases_x64/SlackSetup.exe'
    checksum        = 'A1BD626F056A29209D34C21CBAFD5994D10CB1D92C2EEA98E5DD629B7CC9C525'
    silentArgs      = '/s'
}

Install-Package $arguments
