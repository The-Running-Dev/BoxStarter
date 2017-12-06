$arguments      = @{
    url         = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe'
    checksum    = '6416B800F6A89C0216986C279EFBBCC99209A39EE4EC1EFC3D6BCE22EE63CDD6'
    silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-Package $arguments
