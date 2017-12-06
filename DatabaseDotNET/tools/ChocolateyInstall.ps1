$arguments = @{
    url        = 'http://fishcodelib.com/files/DatabaseNet4.zip'
    checksum   = '98506F615C11BBE76F4392C6F3BB93B53238427E007DB3631AB92B3DF86D6046'
    destination = Join-Path $env:AppData 'DatabaseDotNET'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'Database4.exe')
