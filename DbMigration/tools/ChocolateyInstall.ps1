$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = 'D4F0839CD87899DEC8BBD8845FAD54C638F49BCEB904326DD7FB21262533529F'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
