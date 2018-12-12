$arguments      = @{
    url         = 'https://download.cloud.lastpass.com/windows_installer/lastappinstall_x64.exe'
    checksum    = '1D7E096A187E697B62EF07667992E4CE62DB727F6CFA25EC2E1D957B14C77EDF'
    silentArgs  = '-si'
}

Install-WithAutoHotKey $arguments
