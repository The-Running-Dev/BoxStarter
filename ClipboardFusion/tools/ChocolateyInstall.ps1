$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.3.exe'
    checksum        = 'F07A3C5A68987410FEB764FF8BC30B81B88DB3726C8F94EC91A119211D124423'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
