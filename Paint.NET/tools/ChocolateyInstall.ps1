$arguments              = @{
    url                 = 'https://www.dotpdn.com/files/paint.net.4.0.17.install.zip'
    checksum            = '4C6F4A582BCDC8E46898D13E6EAFC6358C21D8DB203DCE4EF26AB149F820752F'
    destination         = Join-Path $env:Temp 'Paint.NET'
    executable          = 'paint.net.4.0.17.install.exe'
    executableArgs      = '/auto'
}

Install-FromZip $arguments
