$arguments          = @{
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.4.1.exe'
    checksum        = '63B35B5050853C93A793624B41B6ABBF7BEBAA1A1D5B746A4E5039BE1CD61352'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
}

Install-Package $arguments
