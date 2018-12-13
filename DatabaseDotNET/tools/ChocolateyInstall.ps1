$arguments = @{
    url         = 'https://fishcodelib.com/files/DatabaseNet4.zip'
    checksum    = '3A2FB4F4485435A7026B98FE5EAE7E8C96959F26A411B44F9FC95A983B9A7786'
    destination = Join-Path $env:AppData 'DatabaseDotNET'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'Database4.exe')
