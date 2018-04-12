$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v18.04.09/ConEmuSetup.180409.exe'
    checksum        = '76591BBB661147B6E4E569ADC9F67D66154E1A38EBA94CD8A277A00639B8470E'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
