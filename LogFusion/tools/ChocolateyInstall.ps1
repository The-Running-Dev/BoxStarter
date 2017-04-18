$arguments      = @{
    file        = 'LogFusionSetup-5.2.1.exe'
    url         = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-5.2.1.exe'
    checksum    = '5EBAA729F3763F618961FD406ED5BD1828FEE656E2D330B76B699084623BE902'
    silentArgs  = '/VERYSILENT /LAUNCHAFTER=0 /MERGETASKS=`"!desktopicon,!desktopicon\common,!desktopicon\user`"'
}

Install-Package $arguments
