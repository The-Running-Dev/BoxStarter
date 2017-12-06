$arguments      = @{
    url         = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.1.exe'
    checksum    = 'E32DF85D7D474301B972134D82A86C1E9D0FDA2C9C63A8B6EE6D0505DE2B5F2F'
    silentArgs  = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
}

Install-Package $arguments

Install-BinFile LogFusion 'C:\Program Files (x86)\LogFusion\LogFusion.exe'
