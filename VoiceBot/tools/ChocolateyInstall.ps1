$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-3.0.exe'
    checksum        = '8BC560E85A844F6FD0412E6BD43028F30CB6ACD14AFE4092F02C70072E69BEA9'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
