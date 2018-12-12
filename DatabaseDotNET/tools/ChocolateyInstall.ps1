$arguments = @{
    url        = 'https://fishcodelib.com/files/DatabaseNet4.zip'
    checksum   = 'AFD88A54E838BDB6499E6BD64CA5BF4295F7E1ECC202FBB52933F4F7F0551D24'
    destination = Join-Path $env:AppData 'DatabaseDotNET'
}

Install-FromZip $arguments

New-StartMenuShortcut (Join-Path $arguments.destination 'Database4.exe')
