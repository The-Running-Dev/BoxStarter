$arguments = @{
    url        = 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/59.0.2/win64/en-US/Firefox%20Setup%2059.0.2.exe'
    checksum   = '6FDA0CA5AECA95B72DF87E46FCF8FC97C169718EA3490F9533993FA8D38AF76D'
    silentArgs = '-ms'
}

Install-Package $arguments
