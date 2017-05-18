$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/102/iTunesFusionSetup-3.0.1.exe'
    checksum        = '1B60DDC5AD0246433BB05085F67F19F103B66EF4B8A1706DED48E862614422EF'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
