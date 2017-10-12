$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-3.1.exe'
    checksum        = 'E7E902E9BEAF29041449979105F62E2A945A4AE111221E84919535BED5323655'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
