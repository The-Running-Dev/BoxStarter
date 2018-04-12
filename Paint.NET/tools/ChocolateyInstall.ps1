$arguments              = @{
    url                 = 'https://www.dotpdn.com/files/paint.net.4.0.21.install.zip'
    checksum            = '1FDCB9A9E928A27C0B5B58C5ADE856F5EC934B2A18C5805D336641C00FFF5EC7'
    destination         = Join-Path $env:Temp 'Paint.NET'
    executable          = 'paint.net.4.0.21.install.exe'
    executableArgs      = '/auto'
}

Install-FromZip $arguments
