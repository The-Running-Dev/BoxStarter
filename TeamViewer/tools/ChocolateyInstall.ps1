$arguments          = @{
    url             = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum        = 'B6451F173C7A0E0BF91C2DB865E1D3FA94516D2778AFAD5CF3137AA6A12912D1'
    silentArgs      = '/S'
}

Install-Package $arguments
