$arguments          = @{
    file            = 'ClipboardFusionSetup-5.0-Beta4.exe'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.0-Beta4.exe'
    checksum        = '732A157BD32C1B7679103FD59CC07D60E251354ED000E082113D60BEEE8C1F56'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-CustomPackage $arguments
