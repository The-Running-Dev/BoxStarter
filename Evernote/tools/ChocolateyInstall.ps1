$arguments      = @{
    url         = 'https://cdn1.evernote.com/win6/public/Evernote_6.7.4.5741.exe'
    checksum    = 'AC3A4406E4AD2CE59D6F02B2D01CCD541B2CA346AF0D6B6A54DFD1999EABE8E8'
    silentArgs  = '/quiet'
}

Install-Package $arguments
