$arguments          = @{
    url             = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum        = '009868767950256D823B0E9C6A89B8A7B2CEF63424ADC1840D1350FFA0BD3E42'
    silentArgs      = '/S'
}

Install-Package $arguments
