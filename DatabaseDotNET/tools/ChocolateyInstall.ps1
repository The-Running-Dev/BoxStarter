$arguments = @{
    url        = 'http://fishcodelib.com/files/DatabaseNet4.zip'
    checksum   = 'FE7F85F899D6BD24BDF2BD9685783D8597AD460E63C09713ECD2A029F6A2685D'
    destination = Join-Path $env:AppData 'DatabaseDotNET'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'Database4.exe')
