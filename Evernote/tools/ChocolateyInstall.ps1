$arguments      = @{
    url         = 'https://cdn1.evernote.com/win6/public/Evernote_6.6.4.5512.exe'
    checksum    = 'D909F785B407CBD57ED2B04AB8E95D6F993D54432A1303F6792F4E296DA11B31'
    silentArgs  = '/quiet'
}

Install-Package $arguments
