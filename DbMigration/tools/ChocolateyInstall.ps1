$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = 'CBA3F061095C6441B8A4B4734CFED3B9F857E03D0AB84F3BC05575A682AE1EC2'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
