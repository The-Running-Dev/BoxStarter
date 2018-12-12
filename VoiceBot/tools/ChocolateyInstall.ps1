$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-3.4.exe'
    checksum        = 'CAB0F9D53E261FB59113F2495AD924229A0BBAFFB0896DB4FFAC85AB9954011C'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
