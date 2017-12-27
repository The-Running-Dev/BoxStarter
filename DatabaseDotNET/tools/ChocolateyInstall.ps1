$arguments = @{
    url        = 'http://fishcodelib.com/files/DatabaseNet4.zip'
    checksum   = 'FD3DDC41D49C576F0956EC5C6E1303FBFB84891FBE99FD24EE05243386C10140'
    destination = Join-Path $env:AppData 'DatabaseDotNET'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'Database4.exe')
