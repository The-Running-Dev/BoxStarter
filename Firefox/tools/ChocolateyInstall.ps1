$arguments = @{
    url        = 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/60.0/win64/en-US/Firefox%20Setup%2060.0.exe'
    checksum   = '7C17524551DCE19B7FE6E52A9DCF0F446B270C47651F608C374BEC07DDEB90B3'
    silentArgs = '-ms'
}

Install-Package $arguments
