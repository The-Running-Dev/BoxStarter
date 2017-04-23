$arguments      = @{
    url         = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe'
    checksum    = '17C4B88846BBFD2CA22D983C03475E60A2D36FBDD12A8EDCF1DD767846CFF689'
    silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-Package $arguments
