$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = '60A7B49B59587CB4562459E648084113F9EEFF933AB733758B31471999A669CB'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
