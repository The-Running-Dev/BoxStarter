$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = '5A98FE0A4980778CF3088832038655FBCF0A5DC09F24077F39DA705D359EA4EC'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
