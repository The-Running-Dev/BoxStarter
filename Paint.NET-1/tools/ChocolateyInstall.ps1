$arguments              = @{
    url                 = 'https://www.dotpdn.com/files/paint.net.4.0.19.install.zip'
    checksum            = '549F2869D35437A93E427A5E79309356F913561E10D8CBF247672FD32091D464'
    destination         = Join-Path $env:Temp 'Paint.NET'
    executable          = 'paint.net.4.0.19.install.exe'
    executableArgs      = '/auto'
}

Install-FromZip $arguments
