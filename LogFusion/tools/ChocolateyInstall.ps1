$arguments      = @{
    url         = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.2.exe'
    checksum    = '3693E017652F8944B21658573A65DF4A48AA433CDA904CD153338EE099A3F2B0'
    silentArgs  = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
}

Install-Package $arguments

Install-BinFile LogFusion 'C:\Program Files (x86)\LogFusion\LogFusion.exe'
