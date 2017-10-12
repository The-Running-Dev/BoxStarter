$arguments      = @{
    url         = 'https://cdn1.evernote.com/win6/public/Evernote_6.7.5.5825.exe'
    checksum    = '2AE8872760C5BC72DED0B15D9217016284F0EEE3039995840F757BBC676F9240'
    silentArgs  = '/quiet'
}

Install-Package $arguments
