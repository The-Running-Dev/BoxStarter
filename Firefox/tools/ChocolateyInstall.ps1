$arguments = @{
    url        = 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/59.0.3/win64/en-US/Firefox%20Setup%2059.0.3.exe'
    checksum   = 'C756CD0443E4B92C09424B758B607A82809D42728A407765126A98D8DF0A85F7'
    silentArgs = '-ms'
}

Install-Package $arguments
