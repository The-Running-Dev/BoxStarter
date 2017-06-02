$arguments          = @{
    url             = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum        = '0855CF36274C994A73D4CB60F1554A351760C19F15EC015986D18EF6F1400487'
    silentArgs      = '/S'
}

Install-Package $arguments
