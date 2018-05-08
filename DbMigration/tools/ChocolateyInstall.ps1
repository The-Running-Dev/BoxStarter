$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = '17AF5175A965037E242D1E5B53DD38E9E04A2D2CC03685F86941F9288A0121A6'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
