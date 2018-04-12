$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-3.3.exe'
    checksum        = 'B1294EF4D0EC0CA35C58150E4E3B421EDB38C240496E9784148E6AE2A1F22155'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
