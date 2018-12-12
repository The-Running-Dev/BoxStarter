$arguments              = @{
    url                 = 'https://www.dotpdn.com/files/paint.net.4.1.5.install.zip'
    checksum            = '1100483028B5D4A933F2B9BE6EDB51A42085C25A01A58C04C2B9E913F1BB4DF9'
    destination         = Join-Path $env:Temp 'Paint.NET'
    executable          = 'paint.net.4.1.5.install.exe'
    executableArgs      = '/auto'
}

Install-FromZip $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" 'paint.net*' | Remove-Item
