$arguments      = @{
    url         = 'https://cdn1.evernote.com/win6/public/Evernote_6.8.7.6387.exe'
    checksum    = 'EA93F212D42F0B05B02E110629EA65FADB8A69AD24C6B7C983C410067CF12796'
    silentArgs  = '/quiet'
}

Install-Package $arguments
