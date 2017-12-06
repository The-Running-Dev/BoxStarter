$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.2.1.exe'
    checksum        = '2B160D017D446786AE98B3511A1FC596F543AE25E65BFF0AAC89B5EB94CF43C1'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
