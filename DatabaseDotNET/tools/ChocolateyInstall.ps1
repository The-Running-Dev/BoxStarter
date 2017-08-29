$arguments = @{
    url        = 'http://fishcodelib.com/files/DatabaseNet4.zip'
    checksum   = 'F5AA9ADFD1EF9A4ABC9D1F07CDC3C8F4A496ABBA3352A9F7193C6964EEAACBFE'
    destination = Join-Path $env:AppData 'DatabaseDotNET'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'Database4.exe')
