$arguments          = @{
    file            = 'WebStorm-2017.1.1.exe'
    url             = 'https://download.jetbrains.com/webstorm/WebStorm-2017.1.1.exe'
    checksum        = '794D23C1E0947C330EE2B6CFB0AF17AB62DBCFA6FFF83B2439AB3B6114F87B48'
    silentArgs      = '/S'
}

Install-Package $arguments
