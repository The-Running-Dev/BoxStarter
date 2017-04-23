$arguments          = @{
    url             = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum        = 'A99042E54EC68839AA375A2A205BAF0DFF02160B4A99CE2C887FE5EC7EF69A41'
    silentArgs      = '/S'
}

Install-Package $arguments
