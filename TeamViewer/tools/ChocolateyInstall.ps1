$arguments          = @{
    url             = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum        = 'B348E0701262F54DCB6FA7111973CDE6940102E27691600977A124231FF38E92'
    silentArgs      = '/S'
}

Install-Package $arguments
