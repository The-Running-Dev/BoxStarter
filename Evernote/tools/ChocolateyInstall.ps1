$arguments      = @{
    url         = 'https://cdn1.evernote.com/win6/public/Evernote_6.5.4.4720.exe'
    checksum    = '2A0A4D133197650EF8506CA26CE86927E4E3191A044EA2A08BFE696B1F18A9A2'
    silentArgs  = '/quiet'
}

Install-Package $arguments
