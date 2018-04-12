$arguments      = @{
    url         = 'https://lastpass.com/download/cdn/lastappinstall_x64.exe'
    checksum    = '97E85C7C6F61E831EBC70AD7CDB96768B3E875F3719E84BB05B5B9FD3C55DAA9'
    silentArgs  = '-si'
}

Install-WithAutoHotKey $arguments
