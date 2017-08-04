$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.0-Beta7.exe'
    checksum        = 'E8B7C8D64728BCA4C2CCC415D8395E48F71282F7B485301E5A998685CB9957CC'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
