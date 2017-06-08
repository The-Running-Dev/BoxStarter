$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/102/iTunesFusionSetup-3.1.exe'
    checksum        = '66CC4D7AD2D8E23C41013F20E0CA5109D452DF7A04EB027A6CD1312764875AB9'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
