$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = '6821D05892662B4A02AA609F14371F7735C9687CE1C6DBB5E717DDAEDB8FA814'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
