$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = 'BF6D65A970117D5314E79671B7022197BAA82BA25C847FD015B04CD39F30A721'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
