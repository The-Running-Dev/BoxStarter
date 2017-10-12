$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.1.1.exe'
    checksum        = '762FECEDCA303C525330DC4D074EDEE0981237A68FF471EB5380A9AB011BDD1D'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
