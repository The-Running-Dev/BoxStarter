$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/102/iTunesFusionSetup-2.6.exe'
    checksum        = '2CE11CE6F3C5ED6A6B24D47C9EA346488BA5FA46AE525B31F9ADF7246E06FA1F'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
