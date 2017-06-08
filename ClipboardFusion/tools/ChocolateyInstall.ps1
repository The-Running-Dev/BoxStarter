$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.0-Beta5.exe'
    checksum        = 'FAEF0071EBAE896DC532BE19831B39A417FA6FA9AD984FADE17E396A4712D1E1'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
