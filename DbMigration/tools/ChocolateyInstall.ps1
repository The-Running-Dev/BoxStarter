$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = '1D7A4CDE9705E85C1E52040469DB7DE097B543DF0E351EBC7221712775BAB117'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
