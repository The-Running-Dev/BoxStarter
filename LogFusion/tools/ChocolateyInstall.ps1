$arguments      = @{
    url         = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.0.1.exe'
    checksum    = 'D2695BA81761297A85CD3E2A9F1B805A2361F5F60896C32550C86D9E9103FBD4'
    silentArgs  = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
}

Install-Package $arguments

Install-BinFile LogFusion 'C:\Program Files (x86)\LogFusion\LogFusion.exe'
