$arguments      = @{
    url         = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.1.1.exe'
    checksum    = '5CEA52C705E710F6CBC472C146F7D9A6C66E8367BEF30B126F4674A52F00EE59'
    silentArgs  = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
}

Install-Package $arguments

Install-BinFile LogFusion 'C:\Program Files (x86)\LogFusion\LogFusion.exe'
