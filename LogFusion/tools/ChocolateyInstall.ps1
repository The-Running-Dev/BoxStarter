$arguments      = @{
    url         = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.0.exe'
    checksum    = '995FFF6D2819F1B1B8B3929CED8142DE02E4909F170E812E93C71AE0C768C08B'
    silentArgs  = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
}

Install-Package $arguments

Install-BinFile LogFusion 'C:\Program Files (x86)\LogFusion\LogFusion.exe'
