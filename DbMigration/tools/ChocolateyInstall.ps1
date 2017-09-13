$arguments = @{
    url         = 'http://fishcodelib.com/files/DBMigration.zip'
    checksum    = 'E0BCEE1BC40B7C6E160C79D80BEAD2DFDCD758DD1D2FC6072E88BC8F0DAECDB9'
    destination = Join-Path $env:AppData 'DBMigration'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'DBMigration.exe')
