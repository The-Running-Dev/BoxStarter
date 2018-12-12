$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/102/iTunesFusionSetup-3.3.exe'
    checksum        = '5530D377CDFC5A9A8C4F2B4C104CFB197316BDD07E3890E1B1727E0146495B97'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
