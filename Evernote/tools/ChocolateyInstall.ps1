$arguments      = @{
    url         = 'https://cdn1.evernote.com/win6/public/Evernote_6.11.2.7027.exe'
    checksum    = 'A0146F555433A21ABFA536E3D99B0889D62838AD3CC0213428D910F974166571'
    silentArgs  = '/quiet'
}

Install-Package $arguments
