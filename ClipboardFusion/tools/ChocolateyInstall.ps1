$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.0-Beta6e.exe'
    checksum        = '1F848CBEC731DE5CCF6D9DCDC9FBB73ACEC133B065103E17721D739029C25360'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
