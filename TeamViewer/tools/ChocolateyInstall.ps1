$arguments          = @{
    url             = 'https://download.teamviewer.com/download/TeamViewer_Setup_en.exe'
    checksum        = '4CDCD6B9DF31CD0678F827FE2BAECBCC3C16B3F64997CFDFB91A445782E97A39'
    silentArgs      = '/S'
}

Install-Package $arguments
