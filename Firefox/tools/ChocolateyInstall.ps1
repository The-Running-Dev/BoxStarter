$arguments = @{
    url        = 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/64.0/win64/en-US/Firefox%20Setup%2064.0.exe'
    checksum   = '509B75C6FCF4A201B13C2CA6F84FCDEAF0EA6A5BA3CCA7B9039D2DA8A41740DE'
    silentArgs = '-ms'
}

Install-Package $arguments
