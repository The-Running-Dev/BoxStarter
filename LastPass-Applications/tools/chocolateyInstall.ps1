$arguments      = @{
    url         = 'https://lastpass.com/download/cdn/lastappinstall_x64.exe'
    checksum    = '29CB9F2E69CFED90DCEFBEC8A13615BA7DB9C1B74AE6EFFAD1D0E0A078A30BB9'
    silentArgs  = '-si'
}

Install-WithAutoHotKey $arguments
