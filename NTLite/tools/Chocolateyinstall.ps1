$arguments      = @{
    url         = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe'
    checksum    = '759BF2FF76A90668884298602B65DFEB61BEBFD246137B54536F8AC4909DC818'
    silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-Package $arguments
