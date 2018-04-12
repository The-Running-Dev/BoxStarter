$arguments      = @{
    url         = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe'
    checksum    = 'FF6FB0BF78AF40956FF5B548BAC8EC8F603D90D9DB7F15338A3063CF298492C8'
    silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-Package $arguments
