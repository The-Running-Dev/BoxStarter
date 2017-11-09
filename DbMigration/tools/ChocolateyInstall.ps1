$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = 'D0E845179743B0EAD5811826E149A66FAB7C048DBFCBFBED136D43FAD13D5410'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
